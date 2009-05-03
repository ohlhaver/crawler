class Feedpage < ActiveRecord::Base

  validates_presence_of :url
  has_many :rawstories
  belongs_to :source
  has_many :feedpage_health_metrics

  def create_health_metrics(monday=nil)
    FeedpageHealthMetric.metric_types.collect do |metric_type|
      monday ||= Time.now.monday
      FeedpageHealthMetric.create!(
        :feedpage_id     => self.id,
        :source_id       => self.source_id,
        :metric_type     => metric_type,
        :calculated_from => monday,
        :calculated_upto => monday
      )
    end
  end

  class << self
   def calculate_and_save_health_metrics
     current_time          = Time.now
     current_monday        = current_time.monday
     # Find all health metrics
     health_metrics        = FeedpageHealthMetric.find(:all)
     health_metrics_hashed = health_metrics.group_by{|h| h.feedpage_id}
 
     # Find the last calculated_upto date of the feedpages
     last_caculated_upto   = health_metrics.collect!{|h| h.calculated_upto}.min

     # Find all the feedpages
     feedpages             = Feedpage.find(:all)

     # Find all the stories created after last_caculated_upto value
     new_stories           = Rawstory.find(:all,
                                           :conditions => ["created_at >= ?", last_caculated_upto], 
                                           :select => "id,feedpage_id, created_at, (title IS NULL or title = '') as is_title_empty, (author_id IS NULL or author_id = '') as is_author_empty, (body IS NULL or body = '') as is_body_empty")
     new_stories_hashed     = new_stories.group_by{|s| s.feedpage_id }

     feedpages.each do |page|
       # Get the metrics records for the feedpage
       # Create them if they do not exist
       page_metrics     = health_metrics_hashed[page.id]
       page_metrics     = page.create_health_metrics if page_metrics.blank?

       # Get the latest stories for the feedpage
       page_stories     = new_stories[page.id].to_a
       
       last_week_metric = page_metrics.find_all{|m| m.metric_type = FeedpageHealthMetric::MetricType::LASTWEEK}.first
       sum_metric       = page_metrics.find_all{|m| m.metric_type = FeedpageHealthMetric::MetricType::SUM}.first
       maximum_metric   = page_metrics.find_all{|m| m.metric_type = FeedpageHealthMetric::MetricType::MAXIMUM}.first

       week_counts = []

       page_last_calculated_upto = sum_metric.calculated_upto
       page_next_calculated_upto = page_last_calculated_upto + 7.days

       while page_next_calculated_upto <= current_monday
         page_week_stories = page_stories.find_all{|s| s.created_at >= page_last_calculated_upto and s.created_at < page_next_calculated_upto}
         week_title_count, week_author_count, week_body_count = 0,0,0
         page_week_stories.each do |s|
           week_title_count  += 1 if s.is_title_empty == "0" 
           week_author_count += 1 if s.is_author_empty == "0" 
           week_body_count   += 1 if s.is_body_empty == "0" 
         end
         week_counts << [week_title_count, week_author_count, week_body_count]
         page_last_calculated_upto = page_next_calculated_upto 
         page_next_calculated_upto = page_last_calculated_upto + 7.days
       end
       # calculate and save latest counts
       if week_counts.size > 0
         last_week_count                    = week_counts.last
         last_week_metric.title_count       = last_week_count[0]
         last_week_metric.author_count      = last_week_count[1]
         last_week_metric.body_count        = last_week_count[2]
         last_week_metric.week_count       += week_counts.size
         last_week_metric.calculated_upto   = page_last_calculated_upto
         
         sum_metric.title_count            += week_counts.sum{|c| c[0]}
         sum_metric.author_count           += week_counts.sum{|c| c[1]}
         sum_metric.body_count             += week_counts.sum{|c| c[2]}
         sum_metric.week_count             += week_counts.size
         sum_metric.calculated_upto         = page_last_calculated_upto

         maximum_metric.title_count        += week_counts.max{|c1,c2| c1[0] <=> c2[0]}[0]
         maximum_metric.author_count       += week_counts.max{|c1,c2| c1[1] <=> c2[1]}[1]
         maximum_metric.body_count         += week_counts.max{|c1,c2| c1[2] <=> c2[2]}[2]
         maximum_metric.week_count         += week_counts.size
         maximum_metric.calculated_upto     = page_last_calculated_upto

         last_week_metric.save!
         maximum_metric.save! 
         sum_metric.save!
         # Send alert if there is a problem
         problem_with_count   = last_week_metric.title_count < 0.5 * maximum_metric.title_count 
         problem_with_count ||= last_week_metric.title_count <  0.75 * (sum_metric.week_count > 0 ? sum_metric.title_count/sum_metric.week_count.to_f : 0 ) 

         problem_with_count ||= last_week_metric.author_count < 0.5 * maximum_metric.author_count 
         problem_with_count ||= last_week_metric.author_count <  0.75 * (sum_metric.week_count > 0 ? sum_metric.author_count/sum_metric.week_count.to_f : 0 ) 

         problem_with_count ||= last_week_metric.body_count < 0.5 * maximum_metric.body_count 
         problem_with_count ||= last_week_metric.body_count <  0.75 * (sum_metric.week_count > 0 ? sum_metric.body_count/sum_metric.week_count.to_f : 0 ) 

         CrawlerMailer.deliver_feedpage_health_alert(page) if problem_with_count

       end
     end
   end
  end
end

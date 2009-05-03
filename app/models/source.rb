class Source < ActiveRecord::Base
  has_many :feedpages
  has_many :rawstories
  has_many :feedpage_health_metrics

  def get_health_metrics
    return [] if self.feedpage_health_metrics.blank?
    metrics_hashed   = self.feedpage_health_metrics.group_by{|m| m.metric_type}
    lastweek_metrics = metrics_hashed[FeedpageHealthMetric::MetricType::LASTWEEK] 
    sum_metrics      = metrics_hashed[FeedpageHealthMetric::MetricType::SUM] 
    maximum_metrics  = metrics_hashed[FeedpageHealthMetric::MetricType::MAXIMUM] 
    lastweek_health = FeedpageHealthMetric.new(
      :metric_type  =>  FeedpageHealthMetric::MetricType::LASTWEEK,
      :title_count  =>  lastweek_metrics.sum{|m| m.title_count},
      :author_count =>  lastweek_metrics.sum{|m| m.author_count},
      :body_count   =>  lastweek_metrics.sum{|m| m.body_count}
    )
    
    sum_health = FeedpageHealthMetric.new(
      :metric_type  =>  FeedpageHealthMetric::MetricType::SUM,
      :title_count  =>  sum_metrics.sum{|m| m.title_count},
      :author_count =>  sum_metrics.sum{|m| m.author_count},
      :body_count   =>  sum_metrics.sum{|m| m.body_count},
      :week_count   =>  sum_metrics.collect{|m| m.week_count}.max || 0
    )

    maximum_health = FeedpageHealthMetric.new(
      :metric_type  =>  FeedpageHealthMetric::MetricType::MAXIMUM,
      :title_count  =>  maximum_metrics.collect{|m| m.title_count}.max || 0,
      :author_count =>  maximum_metrics.collect{|m| m.author_count}.max || 0,
      :body_count   =>  maximum_metrics.collect{|m| m.body_count}.max || 0,
      :week_count   =>  maximum_metrics.collect{|m| m.week_count}.max || 0
    )
    return [lastweek_health, sum_health, maximum_health]
  end
end

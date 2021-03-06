#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"
require File.dirname(__FILE__) + "/../j_lib.rb"
#include ExceptionNotifiable
$running = true;
Signal.trap("TERM") do 
  $running = false
end
$current_stories = [] 
$current_stories_hashed = {}

def calculate_blub(story, time_now = nil)
  time_now ||= Time.now
  age = ((time_now - story.created_at)/3600).to_i 
  age = 1 if age < 1
  age = (100*(1/(age**(0.33)))).to_i 
  quality_value = story.rawstory_detail.quality rescue 1
  blub =  age*quality_value
  return blub
end

def calculate_score story
  pilot_keys =  @pilot_story.keywords.split(/\ /) 
  story_keys =  story.keywords.split(/\ /)
  score = 0
  pilot_keys.each do |k|
    score += 1 if story_keys.include?(k) 
  end

  #headline_score = 0
  #array =  story.title.split(/\ /)
  #headline_keys = array.collect {|e| e.downcase if e != nil}
  #pilot_keys.each do |k|
  #      headline_score += 1 if headline_keys.include?(k) 
  #end
  #
  #headline_score = 0 if headline_keys.size > 10
  
  #return score, headline_score
  return score
end  
  
def make_group
  politics_score    = 0
  business_score    = 0
  culture_score     = 0
  science_score     = 0
  tech_score        = 0
  sport_score       = 0
  mixed_score       = 0
  source_array      = []
  @current_stories  = @current_stories.find_all{|r| r.related != 1 }
  group             = Group.create
  group.gsession_id = @gsession.id
  group.topic       = @pilot_story.feedpage.topic
  group.pilot       = @pilot_story.id
  group.language    = @pilot_story.language
  #@pilot_story.position = @pilot_story.keywords.scan(/\w+/)
  @current_stories.each do |c|
    if c.language ==  group.language
      if c.title != nil 
        #c.position = c.keywords.scan(/\w+/)
        #c.score, c.hscore = calculate_score c 
        c.score = calculate_score c 
        if c.score > 4 && c.related != 1 && c.language == 1
          c.group_id = group.id
          c.related  = 1 if @save == 1
          #c.save 
          if @save == 1
            topic = c.feedpage.topic
            politics_score +=1 if topic == 2
            business_score +=1 if topic == 5
            culture_score +=1 if topic == 3
            science_score +=1 if topic == 4
            tech_score  +=1 if topic == 9
            sport_score  +=1 if topic == 6
            mixed_score  +=1 if topic == 7
          end
          # group.topic = c.feedpage.topic if @save == 1 && group.topic == 1 && c.feedpage.topic != 1   
          source_array << c.source.id unless source_array.include?(c.source.id)
        end  
        if c.score > 3 && c.related != 1 && c.language == 2
          c.group_id = group.id
          c.related = 1 if @save == 1
          #c.save 
          if @save == 1
            topic = c.feedpage.topic
            politics_score +=1 if topic == 2
            business_score +=1 if topic == 5
            culture_score +=1 if topic == 3
            science_score +=1 if topic == 4
            tech_score  +=1 if topic == 9
            sport_score  +=1 if topic == 6
            mixed_score  +=1 if topic == 7
          end
          #    group.topic = c.feedpage.topic if @save == 1 && group.topic == 1 && c.feedpage.topic != 1   
          source_array << c.source.id unless source_array.include?(c.source.id)
        end
      end
    end
  end
  if  @save == 1
    record_score = 0
    group_topic = nil
    if politics_score > 0
      group_topic = 2
      record_score = politics_score
    end

    if business_score > record_score
      group_topic = 5
      record_score = business_score
    end

    if culture_score > record_score
      group_topic = 3
      record_score = culture_score
    end

    if science_score > record_score
      group_topic = 4
      record_score = science_score
    end

    if tech_score > record_score
      group_topic = 9
      record_score = tech_score
    end

    if sport_score > record_score
      group_topic = 6
      record_score = sport_score
    end

    if mixed_score > record_score
      group_topic = 7
      record_score = mixed_score
    end
    group.topic = group_topic if group_topic
  end
  @related_stories = @current_stories.find_all{|v| v.group_id == group.id } 
  group.weight = @related_stories.size
  group.broadness = source_array.size 
  group.save
  if @save == 1 && group.broadness > 1
    @pilot_story.group_id = group.id 
    @pilot_story.related = 1
    #@pilot_story.save
  end
end
 
def build_groups
  Eintrag.create(:name => 'Group building 1 started')   
  starting_time    = Time.new
  @gsession        = Gsession.create
  last_gsession_id = @gsession.id
  @current_stories = $current_stories.find_all{|r| r.keywords != nil }       
  @save            = 0  
  @current_stories.each do |story|
    begin  
      @pilot_story = story
      make_group  #if @pilot_story.keywords != nil
    rescue StandardError, Interrupt              
    end           
  end

  finishing_time = Time.new
  duration       = (finishing_time - starting_time)
  Eintrag.create(:name => 'Group building 1 completed', :duration => duration)

  starting_time = Time.new
  @groups       = @gsession.groups 
  @groups       = @groups.find_all {|u| u.weight > 1 } 
  @groups       = @groups.sort_by {|u| - u.weight }  
  @gsession     = Gsession.create
  @save         = 1  

  @groups.each do |g|   
    @pilot_story = $current_stories_hashed[g.pilot].to_a[0]
    make_group
  end  
  Group.delete_all(" gsession_id < #{last_gsession_id}")
  finishing_time = Time.new
  duration       = (finishing_time - starting_time)
  Eintrag.create(:name => 'Group building 2 completed', :duration => duration)
end


def build_haufens
  starting_time = Time.new
  @hsession     = Hsession.create
  @groups       = @gsession.groups  
  @groups       = @groups.find_all {|u| u.broadness > 1 }
  @groups       = @groups.sort_by {|u| - u.broadness } 
  stories_hashed     = $current_stories.group_by{|s| s.group_id} 
  
  
  @groups.each do |group|
    haufen             = Haufen.create
    haufen.hsession_id = @hsession.id
    haufen.topic       = group.topic
    haufen.pilot       = group.pilot
    haufen.language    = group.language
    haufen.broadness = (group.broadness * 100) + group.weight
    haufen_stories = stories_hashed[group.id]
    
    time_now = Time.new
    sorted_stories =  haufen_stories.sort_by{|story| - calculate_blub(story, time_now)}
    haufen.latest        = sorted_stories.first.id
    haufen.top_story_ids = sorted_stories.find_all{|s| s.rawstory_detail.is_duplicate == false}[0,5].collect{|s| s.id}*","
    
    
    group_stories = stories_hashed[group.id]
    haufen.weight = group_stories.size

    videos        = group_stories.find_all {|u| u.video == true }
    haufen.videos   = videos.size

    members = ''
    group_stories.each do |story|
      members += story.id.to_s + ' '  
      story.haufen_id = haufen.id
      story.save
    end
    haufen.members  = members
    haufen.keywords = JLib.find_haufen_keywords(group_stories)*' '

    haufen.save!


    # Start : Find the  image for the haufen
    image_found = false
    i = 0
    while !image_found and i < sorted_stories.size
      s = sorted_stories[i]
      if s.rawstory_detail.image_exists
        HaufensStoryImage.create!(:haufen_id => haufen.id, :story_image_id => s.rawstories_story_image.story_image.id)
        haufen.image_exists = true
        haufen.image_story_id = s.id
        haufen.save!
        image_found = true
      end
      i += 1
    end
    # End : Find the  image for the haufen
  end
  finishing_time = Time.new
  duration = (finishing_time - starting_time)
  Eintrag.create(:name => 'Haufen building completed', :duration => duration)
end

def generate_opinions
  @stories = $current_stories   

  @en_stories = @stories.find_all{|v| v.language == 1 }
  @en_opinions = @en_stories.find_all{|v| v.opinion == 1 }
  @en_opinions = @en_opinions.find_all{|v| v.author.name != '' }
  @en_opinions = @en_opinions.sort_by {|u| - u.author.subscriptions.size}
  @en_opinions = @en_opinions.first(24)

  @de_stories = @stories.find_all{|v| v.language == 2 }
  @de_opinions = @de_stories.find_all{|v| v.opinion == 1 }
  @de_opinions = @de_opinions.find_all{|v| v.author.name != '' }
  @de_opinions = @de_opinions.sort_by {|u| - u.author.subscriptions.size}
  @de_opinions = @de_opinions.first(24)

  @all_opinions = @stories.find_all{|v| v.opinion == 1 }
  @all_opinions = @all_opinions.find_all{|v| v.author.name != '' }
  @all_opinions = @all_opinions.sort_by {|u| - u.author.subscriptions.size}
  @all_opinions = @all_opinions.first(24)

  opinions_en = ''
  @en_opinions.each do |opinion|
    opinions_en += opinion.id.to_s + ' '
  end

  opinions_de = ''
  @de_opinions.each do |opinion|
    opinions_de += opinion.id.to_s + ' '
  end

  opinions_all = ''
  @all_opinions.each do |opinion|
    opinions_all += opinion.id.to_s + ' '
  end

  new_list = Olist.create      
  new_list.en = opinions_en
  new_list.de = opinions_de
  new_list.all = opinions_all     
  new_list.save
end
    

while($running) do
   Eintrag.create(:name => 'clustering started')
   clustering_start_time = Time.now   
   $current_stories = Rawstory.find(:all, :conditions => ['created_at > :date', {:date => Time.now.yesterday}], :order => 'rawstories.id DESC', :include => [:feedpage, :rawstory_detail]) 
   $current_stories_hashed = $current_stories.group_by{|s| s.id}
   build_groups
   build_haufens
   generate_opinions
   clustering_end_time = Time.now   
   duration = clustering_end_time - clustering_start_time
   Eintrag.create(:name => 'clustering completed', :duration => duration)   
   #$current_stories.each do |story|
   # story.save
   #end
   sleep 10
end

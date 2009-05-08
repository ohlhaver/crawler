#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"
#include ExceptionNotifiable
$running = true;
Signal.trap("TERM") do 
  $running = false
end

def get_dissimilarity_value(id1, id2)
  $dissimilarity_values[id1] ||= {}
  $dissimilarity_values[id2] ||= {}
  return $dissimilarity_values[id1][id2]
end

def set_dissimilarity_value(id1, id2, val)
  $dissimilarity_values[id1][id2] = val
  $dissimilarity_values[id2][id1] = val
end

def find_dissimilarity(story1, story2)
  dissimilarity = get_dissimilarity_value(story1.id, story2.id)
  if dissimilarity.nil?
     story1_keys = story1.all_keywords.uniq
     story2_keys = story2.all_keywords.uniq

     if  (story1.id == story2.id) or (story1_keys.blank? and story2_keys.blank?)
       dissimilarity = 1 # We don't treat them as duplicates
     else
       all_keys    = (story1_keys + story2_keys).uniq
       a = story1_keys.size
       b = story2_keys.size
       c = all_keys.size
       dissimilarity  = (2*c-a-b)/c.to_f
       #dissimilarity = JLib.levenshtein_distance(story1.body, story2.body)/([story1.body.size, story2.body.size].max.to_f)
       #dissimilarity = 1 # We don't treat them as duplicates
     end
     set_dissimilarity_value(story1.id, story2.id, dissimilarity)
  end
  return dissimilarity
end

def find_dissimilarities(stories)
  stories.each do |story1|
    stories.each do |story2|
      find_dissimilarity(story1, story2)
    end
  end
end

def find_duplicates
  # Compare stories from same source
  $story_hash_by_source.keys.each do |source_id|
    find_dissimilarities($story_hash_by_source[source_id].to_a) unless source_id.blank?
  end

  # Compare stories by same author
  $story_hash_by_author.keys.each do |author_id|
    find_dissimilarities($story_hash_by_source[author_id].to_a) unless author_id.blank?
  end


  duplicates_map       = {}
  # Filter out duplicates
  $dissimilarity_values.keys.each do |id1|
    story_comapres = $dissimilarity_values[id1]
    duplicates_map[id1] ||= []
    story_comapres.keys.each do |id2|
      duplicates_map[id1] << id2 if get_dissimilarity_value(id1, id2) < 0.1
    end
  end
 
  # Find duplicate groups
  duplicate_groups = []
  duplicates_map.keys.each do |id|
    duplicate_groups << (duplicates_map[id] << id).uniq unless duplicates_map[id].blank?
  end

  # Merge groups
  groups = []
  current_group = duplicate_groups.delete_at(0)
  while current_group
    i = 0
    while i < duplicate_groups.size
      compare_group = duplicate_groups[i]
      u = current_group + compare_group
      uniq_u = u.uniq
      if u.size > uniq_u.size # groups overlap
        # Merge the groups
        current_group = uniq_u
        duplicate_groups.delete_at(i)
      else
        i += 1
      end
    end
    
    groups << current_group
    current_group = duplicate_groups.delete_at(0)
  end
  
  # Store the group information into File
  #File.open('DuplicateGroups.txt', 'a') do |f|
  #  f.puts "#{Time.now.to_s(:db)} Duplicate Groups : Start"
  #    groups.each do |g|
  #      f.puts g.inspect
  #    end
  #  f.puts "#{Time.now.to_s(:db)} Duplicate Groups : End"
  #end
  # Store the group information into db
  story_groups = []
  groups.each do |g|
   puts g.inspect
   s_g = []
   unless g.blank?
     g.each do |id|
      puts id.inspect
      s =  $story_hash_by_id[id.to_i].to_a.first
      s_g << s if s
     end
     story_groups << s_g unless s_g.blank?
   end
  end 
  # Store each group
  story_groups.each do |story_group|
     next if story_group.blank?
     # Find if the stories belong to an existing group
     d_g_ids = []
     story_group.each do |s|
       d_g_ids <<  s.rawstory_detail.duplicate_group_id if s.rawstory_detail.duplicate_group_id != 1
     end
     d_g_id = 1
     if d_g_ids.blank?
       d_g_id = DuplicateGroup.create!().id 
     else
       d_g_id = d_g_ids.sort.last
     end
     
     # Save the duplicate group id
     s_ids = story_group.collect{|s| s.id}*","
     lead_story = find_lead(story_group)
     RawstoryDetail.update_all(["duplicate_group_id = #{d_g_id}, is_duplicate = (CASE WHEN #{lead_story.id}  THEN :false ELSE :true END)", {:false => false, :true => true}], 
                               "rawstory_id IN ( #{s_ids} )")
     Rawstory.update_all(["updated_at = :time ", :time => Time.now], "id IN ( #{s_ids} )")
     
  end
end

def find_lead(groups)
  sorted_group  = groups.sort_by{|s| s.created_at}.reverse
  lead_not_found    = true
  i                 = 0
  lead_story        = nil
  while lead_not_found and i < sorted_group.size
    if sorted_group[i].author.name.blank?
      i += 1
    else
      lead_story = sorted_group[i]
      break
    end
  end
  lead_story = sorted_group.first if lead_story.nil?
  return lead_story
end

while($running) do
  Eintrag.create(:name => 'Duplicate finding started')
  start_time            = Time.now   
  #####################################
  # Initialize global variables : Start
  #####################################
  $stories              = [] 
  $story_hash_by_id     = {}
  $story_hash_by_author = {}
  $story_hash_by_source = {}
  $dissimilarity_values = {}

  #####################################
  # Initialize global variables : End
  #####################################

  $stories              = Rawstory.find(:all,
                                        :conditions => ['rawstories.created_at > :date', {:date => Time.now.yesterday}],
                                        :order => 'rawstories.id DESC',
                                        :include => [:rawstory_detail]) 

  #$stories.each{|story| story.body.gsub!(/\W/,' ') if story.body}

  $story_hash_by_author = $stories.group_by{|s| s.author_id}
  $story_hash_by_source = $stories.group_by{|s| s.source_id}
  $story_hash_by_id     = $stories.group_by{|s| s.id}
  find_duplicates

  end_time = Time.now   
  duration = end_time - start_time
  Eintrag.create(:name => 'Duplicate finding ended', :duration => duration)   
  sleep 10
end

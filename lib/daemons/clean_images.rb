#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"
$running = true;
Signal.trap("TERM") do 
  $running = false
end
  
while($running) do
  Eintrag.create(:name => 'Image cleaning started')   
  starting_time    = Time.new
  images = StoryImage.find(
    :all,
    :conditions => ["created_at < :two_days_ago and image_exists = :true ", {:true => true, :two_days_ago => (Time.now - 48.hours)}] 
  )
  images.each do |i|
    i.remove_image
    RawstoriesStoryImage.find(:all, :conditions => ["story_image_id = ?", i.id]).each do |rs|
      s = RawstoryDetail.find_by_rawstory_id(rs.rawstory_id)
      if s
        s.image_exists = false
        s.save!
      end
      rs.destroy
    end
    HaufensStoryImage.find(:all, :conditions => ["story_image_id = ?", i.id]).each do |hs|
      h = Haufen.find(hs.haufen_id)
      if h
        h.image_exists = false
        h.save!
      end
      hs.destroy
    end
    i.destroy
  end
  end_time         = Time.new
  duration         =  end_time - starting_time 
  Eintrag.create(:name => 'Image cleaning ended', :duration => duration)   
  sleep 600
end

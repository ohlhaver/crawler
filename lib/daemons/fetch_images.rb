#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"
require 'rubygems/open-uri'

$running = true;
Signal.trap("TERM") do 
  $running = false
end
  
while($running) do
  Eintrag.create(:name => 'Image fetching started')   
  starting_time    = Time.new
  images = StoryImage.find(
    :all,
    :conditions => ["created_at > :one_day_ago and image_exists = :false ", {:false => false, :one_day_ago => (Time.now - 1.day)}] 
  )
  images.each do |i|
    begin
      d = open(i.baseurl)

    i.store_image(d.read, d.content_type)
    RawstoriesStoryImage.find(:all, :conditions => ["story_image_id = ?", i.id]).each do |rs|
      s = RawstoryDetail.find_by_rawstory_id(rs.rawstory_id)
      s.image_exists = true
      s.save!
    end
    rescue      
      next
    end
  end
  end_time         = Time.new
  duration         =  end_time - starting_time 
  Eintrag.create(:name => 'Image fetching ended', :duration => duration)   
  if duration < 10
   sleep 300
  else 
   sleep 60
  end
end

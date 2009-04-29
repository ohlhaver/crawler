#!/usr/bin/env ruby
ENV["RAILS_ENV"] ||= "production"
require File.dirname(__FILE__) + "/../../config/environment"
require File.dirname(__FILE__) + "/../custom_logger"

$log     = CustomLogger.new "#{File.dirname(__FILE__)}/../../log/daemon_#{File.basename(__FILE__)}.log"
$running = true;
Signal.trap("TERM") do 
  $running = false
  $log.info "Daemon Killed"
end

$log.info "Daemon Started"

while $running do
  begin

  rescue Exception => e
  end
end


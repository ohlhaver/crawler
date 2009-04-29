#!/usr/bin/env ruby
require 'logger'

class CustomLogger < Logger
  def info msg
    super "#{Time.now.to_s(:db)} : #{msg}"
  end
  def error msg
    super "#{Time.now.to_s(:db)} : #{msg}"
  end
end

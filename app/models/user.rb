class User < ActiveRecord::Base
  has_one :home_page_conf

  class Alert
    OFF       = 0
    IMMEDIATE = 1
    DAILY     = 2
    WEEKLY    = 3
  end
end

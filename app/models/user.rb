class User < ActiveRecord::Base
  has_one :home_page_conf
end

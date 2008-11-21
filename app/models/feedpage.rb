class Feedpage < ActiveRecord::Base

validates_presence_of :url
has_many :rawstories
belongs_to :source

end

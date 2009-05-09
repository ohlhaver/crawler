class UniqueAuthor < ActiveRecord::Base
  validates_presence_of :name
  has_many :author_map
end

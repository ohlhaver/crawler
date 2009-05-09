class Author < ActiveRecord::Base
has_many :rawstories
has_many :subscriptions
has_one :author_map
end

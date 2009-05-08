class RawstoryDetail < ActiveRecord::Base
  belongs_to :rawstory
  belongs_to :duplicate_groups
end

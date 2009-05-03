class Rawstory < ActiveRecord::Base
  attr_accessor :position, :score, :related
  belongs_to :group
  belongs_to :author
  belongs_to :feedpage
  belongs_to :source
  belongs_to :haufen
  has_one    :rawstory_detail
  is_indexed :fields =>[
  {:field => :title},
  {:field => :body},
  {:field => :opinion},
  {:field => :created_at}]
  
end

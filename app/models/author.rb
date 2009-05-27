class Author < ActiveRecord::Base
  has_many :rawstories
  has_many :subscriptions
  has_one :author_map
  is_indexed :fields =>[{:field => :name},
                        {:field => :opinionated},
                        {:field => :approval_status},
                        {:field => :created_at}],
             :delta => true

end

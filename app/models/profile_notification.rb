class ProfileNotification < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true
  belongs_to :user
  class Type
    AUTHOR_RECOMMENDATION_RECEIVED  = 1
    ARTICLE_RECOMMENDATION_RECEIVED = 2
    GOT_NEW_FRIEND                  = 3
  end

end

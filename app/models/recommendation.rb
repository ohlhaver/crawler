class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :recommender,
             :class_name => 'User',
             :foreign_key => 'recommender_id'
  belongs_to :resource, :polymorphic => true

  def self.create_article_recommendation(article_id, recommender_id, user_id)
    r = Recommendation.find(:all, 
                            :conditions => ["recommender_id = :recommender_id and user_id = :user_id and resource_id = :article_id and resource_type = 'Rawstory'",  {:recommender_id => recommender_id.to_i,
                                            :user_id        => user_id.to_i,
                                            :article_id     => article_id.to_i}])
    return unless r.blank?
    Recommendation.create!(:recommender_id => recommender_id,
                           :user_id        => user_id,
                           :resource_id    => article_id,
                           :resource_type  => "Rawstory")

  end

  def self.create_author_recommendation(author_id, recommender_id, user_id)
    r = Recommendation.find(:all, 
                            :conditions => ["recommender_id = :recommender_id and user_id = :user_id and resource_id = :author_id and resource_type = 'Rawstory'",  {:recommender_id => recommender_id.to_i,
                                            :user_id        => user_id.to_i,
                                            :author_id     => author_id.to_i}])
    return unless r.blank?
    Recommendation.create!(:recommender_id => recommender_id,
                           :user_id        => user_id,
                           :resource_id    => author_id,
                           :resource_type  => "Author")

  end

  def article?
    case resource_type.strip
    when "Rawstory"
      true
    else
      false
    end
  end
  def author?
    case resource_type.strip
    when "Author"
      true
    else
      false
    end
  end
  def article
    article? ? resource : nil
  end
  def author
    author? ? resource : nil
  end

  def after_create
    ProfileAction.create_recommended_action(self)
  end
end

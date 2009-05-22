class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.integer :recommender_id, :limit => 11, :null => false, :default => 0
      t.integer :user_id, :limit => 11, :null => false, :default => 0
      t.integer :resource_id, :limit => 11, :null => false, :default => 0
      t.string  :resource_type, :null => false, :default => ''
      t.string  :message, :null => false, :default => ''
      t.boolean  :active, :null => false, :default => true
      t.timestamps
    end
    add_index :recommendations, [:recommender_id], :name => "index_recommendations_on_recommender_id"
    add_index :recommendations, [:user_id], :name => "index_recommendations_on_user_id"
    add_index :recommendations, [:resource_id], :name => "index_recommendations_on_resource_id"
  end

  def self.down
    drop_table :recommendations
  end
end

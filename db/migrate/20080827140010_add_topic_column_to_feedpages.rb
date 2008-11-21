class AddTopicColumnToFeedpages < ActiveRecord::Migration
  def self.up
    add_column :feedpages, :topic, :integer
  end

  def self.down
    remove_column :feedpages, :topic
  end
end

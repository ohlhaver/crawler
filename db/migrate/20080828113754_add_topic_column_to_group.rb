class AddTopicColumnToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :topic, :integer
  end

  def self.down
    remove_column :groups, :topic
  end
end

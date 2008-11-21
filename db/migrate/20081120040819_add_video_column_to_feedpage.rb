class AddVideoColumnToFeedpage < ActiveRecord::Migration
  def self.up
    add_column :feedpages, :video, :boolean
  end

  def self.down
    remove_column :feedpages, :video
  end
end

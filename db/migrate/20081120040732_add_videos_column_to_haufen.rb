class AddVideosColumnToHaufen < ActiveRecord::Migration
  def self.up
    add_column :haufens, :videos, :integer
  end

  def self.down
    remove_column :haufens, :videos
  end
end

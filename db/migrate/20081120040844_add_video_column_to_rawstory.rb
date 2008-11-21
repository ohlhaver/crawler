class AddVideoColumnToRawstory < ActiveRecord::Migration
  def self.up
    add_column :rawstories, :video, :boolean
  end

  def self.down
    remove_column :rawstories, :video
  end
end

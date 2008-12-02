class AddHscoreToRawstory < ActiveRecord::Migration
  def self.up
    add_column :rawstories, :hscore, :integer
  end

  def self.down
    remove_column :rawstories, :hscore
  end
end

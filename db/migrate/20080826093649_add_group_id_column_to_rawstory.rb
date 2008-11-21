class AddGroupIdColumnToRawstory < ActiveRecord::Migration
  def self.up
    add_column :rawstories, :group_id, :integer
  end

  def self.down
    remove_column :rawstories, :group_id
  end
end

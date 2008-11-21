class AddBroadnessColumnToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :broadness, :integer
  end

  def self.down
    remove_column :groups, :broadness
  end
end

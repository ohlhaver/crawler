class AddBroadnessColumnToHaufen < ActiveRecord::Migration
  def self.up
    add_column :haufens, :broadness, :integer
  end

  def self.down
    remove_column :haufens, :broadness
  end
end

class AddWeightColumnToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :weight, :integer
    add_column :groups, :pilot, :integer
    add_column :groups, :gsession, :integer
  end

  def self.down
    remove_column :groups, :weight
    remove_column :groups, :pilot, :integer
    remove_column :groups, :gsession, :integer
  end
end

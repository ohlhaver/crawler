class AddClusterIdColumnToRawstory < ActiveRecord::Migration
  def self.up
    add_column :rawstories, :cluster_id, :integer
  end

  def self.down
    remove_column :rawstories, :cluster_id
  end
end

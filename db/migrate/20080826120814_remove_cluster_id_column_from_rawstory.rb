class RemoveClusterIdColumnFromRawstory < ActiveRecord::Migration
  def self.up
    remove_column :rawstories, :cluster_id
  end

  def self.down
    create_column :rawstories, :cluster_id
  end
end

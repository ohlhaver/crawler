class DropClusters < ActiveRecord::Migration
  def self.up
    drop_table :clusters
  end

  def self.down
    create_table :clusters
  end
end

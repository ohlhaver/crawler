class AddPilotColumnToCluster < ActiveRecord::Migration
  def self.up
    add_column :clusters, :pilot, :integer
  end

  def self.down
    remove_column :clusters, :pilot
  end
end

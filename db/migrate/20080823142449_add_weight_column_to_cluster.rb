class AddWeightColumnToCluster < ActiveRecord::Migration
  def self.up
    add_column :clusters, :weight, :integer
  end

  def self.down
    remove_column :clusters, :weight
  end
end

class AddCSessionColumnToCluster < ActiveRecord::Migration
  def self.up
    add_column :clusters, :c_session, :integer
  end

  def self.down
    remove_column :clusters, :c_session
  end
end

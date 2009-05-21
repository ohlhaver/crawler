class CreateFbInfiniteSessionKeyColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_session_key, :string, :null => false, :default => ''
    add_column :users, :fb_offline_access_permission_granted, :boolean, :null => false, :default => false
    add_column :users, :fb_email_permission_granted, :boolean, :null => false, :default => false
  end
  def self.down
  end
end

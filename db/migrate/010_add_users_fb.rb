class AddUsersFb < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_user_id, :integer, :null => false, :default => 0
    execute("alter table users modify fb_user_id bigint")
    add_column :users, :email_hash, :string, :null => false, :default => ''
    add_column :users, :name, :string, :null => false, :default => ''
    User.update_all("name = login")
    add_index :users, [:fb_user_id], :name => "index_users_on_fb_user_id"
    add_index :users, [:email_hash], :name => "index_users_on_email_hash"
  end

  def self.down
    remove_column :users, :fb_user_id
    remove_column :users, :email_hash
  end
end

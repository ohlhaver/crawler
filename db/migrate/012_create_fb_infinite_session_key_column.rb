class CreateFbInfiniteSessionKeyColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :fb_session_key, :string, :null => false, :default => ''
  end
  def self.down
  end
end

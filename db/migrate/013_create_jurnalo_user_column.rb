class CreateJurnaloUserColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :jurnalo_user, :boolean, :null => false, :default => true
  end
  def self.down
  end
end

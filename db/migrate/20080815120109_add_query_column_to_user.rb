class AddQueryColumnToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :query, :string
    add_column :users, :filter, :integer
    add_column :users, :mode, :integer
  end

  def self.down
    remove_column :users, :query
    remove_column :users, :filter 
    remove_column :users, :mode 
  end
end

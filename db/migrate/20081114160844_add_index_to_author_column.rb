class AddIndexToAuthorColumn < ActiveRecord::Migration
  def self.up
    add_index :authors, :name
    
  end

  def self.down
    remove_index :authors, :name
  end
end

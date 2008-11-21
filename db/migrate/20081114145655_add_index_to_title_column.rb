class AddIndexToTitleColumn < ActiveRecord::Migration
  def self.up
    add_index :rawstories, :title, :unique=>true
    add_index :rawstories, :link, :unique=>true  
  end

  def self.down
    remove_index :rawstories, :title
    remove_index :rawstories, :link
  end
end

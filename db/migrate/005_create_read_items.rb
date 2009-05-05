class CreateReadItems < ActiveRecord::Migration
  def self.up
    create_table :read_items do |t|
      t.integer :user_id, :null => false
      t.integer :rawstory_id, :null => false
      t.timestamps
    end
    add_index :read_items, [:user_id], :name => "index_read_items_on_user_id"
    add_index :read_items, [:rawstory_id], :name => "index_read_items_on_rawstory_id"
  end

  def self.down
    drop_table :read_items
  end
end

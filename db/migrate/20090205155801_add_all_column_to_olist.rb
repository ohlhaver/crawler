class AddAllColumnToOlist < ActiveRecord::Migration
  def self.up
    add_column :olists, :all, :text
  end

  def self.down
    remove_column :olists, :all
  end
end

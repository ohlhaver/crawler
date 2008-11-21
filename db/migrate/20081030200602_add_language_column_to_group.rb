class AddLanguageColumnToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :language, :integer
  end

  def self.down
    remove_column :groups, :language
  end
end

class AddLanguageColumnToHaufen < ActiveRecord::Migration
  def self.up
    add_column :haufens, :language, :integer
  end

  def self.down
    remove_column :haufens, :language
  end
end

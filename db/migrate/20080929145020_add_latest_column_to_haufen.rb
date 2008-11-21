class AddLatestColumnToHaufen < ActiveRecord::Migration
  def self.up
    add_column :haufens, :latest, :integer
  end

  def self.down
    remove_column :haufens, :latest
  end
end

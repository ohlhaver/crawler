class AddHaufenIdColumnToRawstory < ActiveRecord::Migration
  def self.up
    add_column :rawstories, :haufen_id, :integer
  end

  def self.down
    remove_column :rawstories, :haufen_id
  end
end

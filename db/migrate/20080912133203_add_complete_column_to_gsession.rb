class AddCompleteColumnToGsession < ActiveRecord::Migration
  def self.up
    add_column :gsessions, :complete, :integer
  end

  def self.down
    remove_column :gsessions, :complete
  end
end

class RemoveCompleteColumnFromGsession < ActiveRecord::Migration
  def self.up
    remove_column :gsessions, :complete
  end

  def self.down
    create_column :gsessions, :complete
  end
end

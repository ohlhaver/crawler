class AddGsessionIdColumnToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :gsession_id, :integer
  end

  def self.down
    remove_column :groups, :gsession_id
  end
end

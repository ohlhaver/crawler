class RemoveGsessionColumnFromGroup < ActiveRecord::Migration
  def self.up
    remove_column :groups, :gsession
  end

  def self.down
    create_column :groups, :gsession
  end
end

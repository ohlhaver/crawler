class AddMembersColumnToHaufen < ActiveRecord::Migration
  def self.up
    add_column :haufens, :members, :string
  end

  def self.down
    remove_column :haufens, :members
  end
end

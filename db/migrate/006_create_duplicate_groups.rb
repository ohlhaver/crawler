class CreateDuplicateGroups < ActiveRecord::Migration
  def self.up
    create_table :duplicate_groups do |t|
      t.timestamps
    end
    # create a default group
    DuplicateGroup.create!(:id => 1)
    add_column :rawstory_details, :duplicate_group_id, :integer, :limit => 11, :null => false, :default => 1
    add_index  :rawstory_details, [:duplicate_group_id], :name => "index_rawstory_details_on_duplicate_group_id"
  end

  def self.down
  end
end

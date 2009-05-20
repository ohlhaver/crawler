class CreateProfileActions < ActiveRecord::Migration
  def self.up
    create_table :profile_actions do |t|
      t.integer :user_id,            :limit => 11, :null => false, :default => 0
      t.integer :action_type,        :null => false, :default => 0
      t.integer :entity_id,          :limit => 11, :null => false, :default => 0
      t.string  :entity_type,        :null => false, :default => ''
      t.string  :entity_content,     :null => false, :default => ''
      t.integer :receiver_user_id,   :limit => 11, :null => false, :default => 0
      t.timestamps
    end
    add_index :profile_actions, [:user_id], :name => "index_profile_actions_on_user_id"
    add_index :profile_actions, [:entity_id], :name => "index_profile_actions_on_entity_id"
    add_index :profile_actions, [:created_at], :name => "index_profile_actions_on_created_at"
  end

  def self.down
  #drop_table :profile_actions
  end
end

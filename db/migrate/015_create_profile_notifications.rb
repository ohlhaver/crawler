class CreateProfileNotifications < ActiveRecord::Migration
  def self.up
    create_table :profile_notifications do |t|
      t.integer :user_id, :limit => 11, :null => false, :default => 0
      t.integer :notification_type, :null => false, :default => 0
      t.integer :entity_id, :limit => 11, :null => false, :default => 0
      t.string  :entity_type, :null => false, :default => ''
      t.string  :entity_content,  :null => false, :default => ''
      t.boolean :active, :null => false, :default => true
      t.timestamps
    end
    add_index :profile_notifications, [:user_id],    :name => "index_profile_notifications_on_user_id"
    add_index :profile_notifications, [:entity_id],  :name => "index_profile_notifications_on_entity_id"
    add_index :profile_notifications, [:created_at], :name => "index_profile_notifications_on_created_at"
  end

  def self.down
  end
end

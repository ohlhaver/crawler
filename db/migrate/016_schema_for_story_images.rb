class SchemaForStoryImages < ActiveRecord::Migration
  def self.up
    add_column :rawstory_details, :image_exists, :boolean, :null => false, :default => false
    add_column :haufens, :image_exists, :boolean, :null => false, :default => false

    create_table :story_images do |t|
      t.string  :baseurl, :null => false, :default => ''
      t.boolean :image_exists, :null => false, :default => false
      t.string  :content_type, :null => false, :default => ''
      t.string  :dimensions, :null => false, :default => ''
      t.string  :thumb_dimensions, :null => false, :default => ''
      t.string  :thumb_content_type, :null => false, :default => ''
      t.timestamps
    end
    add_index :story_images, [:created_at], :name => "index_story_images_on_created_at"
    
    create_table :rawstories_story_images do |t|
      t.integer :rawstory_id, :null => false, :default => 0
      t.integer :story_image_id, :null => false, :default => 0
      t.timestamps
    end
    add_index :rawstories_story_images, [:rawstory_id], :name => "index_rawstories_story_images_on_rawstory_id"
    add_index :rawstories_story_images, [:story_image_id], :name => "index_rawstories_story_images_on_story_image_id"

    create_table :haufens_story_images do |t|
      t.integer :haufen_id, :null => false, :default => 0
      t.integer :story_image_id, :null => false, :default => 0
      t.timestamps
    end
    add_index :haufens_story_images, [:haufen_id], :name => "index_haufens_story_images_on_haufen_id"
    add_index :haufens_story_images, [:story_image_id], :name => "index_haufens_story_images_on_story_image_id"

  end
  def self.down
  end
end

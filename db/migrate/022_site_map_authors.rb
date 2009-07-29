class SiteMapAuthors < ActiveRecord::Migration

  def self.up
    create_table :site_map_author_categories do |t|
      t.string   :label
    end

    create_table :site_map_author_sub_categories do |t|
      t.string   :label
      t.integer  :category_id
    end
    add_index :site_map_author_sub_categories, [:category_id], :name => "index_site_map_author_sub_categories_on_category_id"

    create_table :site_map_category_author_maps do |t|
      t.integer  :author_id
      t.integer  :sub_category_id
      t.integer  :category_id
    end
    add_index :site_map_category_author_maps, [:author_id], :name => "index_site_map_category_author_maps_on_author_id"
    add_index :site_map_category_author_maps, [:sub_category_id], :name => "index_site_map_category_author_maps_on_sub_category_id"
    add_index :site_map_category_author_maps, [:category_id], :name => "index_site_map_category_author_maps_on_category_id"

  end

  def self.down
   # do nothing
  end

end

class AuthorSwiperAppendix < ActiveRecord::Migration

  def self.up
    add_index :author_maps, [:author_id], :name => "index_author_maps_on_author_id"
    add_index :author_maps, [:unique_author_id], :name => "index_author_maps_on_unique_author_id"
  end

  def self.down
   # do nothing
  end

end

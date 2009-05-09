class AuthorSwiper < ActiveRecord::Migration
  def self.up
    add_column :authors, :approval_status, :boolean, :default => JConst::AuthorStatus::SUGGESTION_PENDING
    add_index :authors, [:approval_status], :name => "index_authors_on_approval_status"

    create_table :unique_authors do |t| 
      t.string :name
      t.integer :opinionated

      t.timestamps
    end 

    create_table :author_maps do |t| 
      t.integer :author_id
      t.integer :unique_author_id
      t.boolean :status, :default => JConst::AuthorMapStatus::UNAPPROVED

      t.timestamps
    end 
    add_index :author_maps, [:status], :name => "index_author_maps_on_status"

  end

  def self.down
    #drop_table :author_maps
    #drop_table :unique_authors
    #remove_column :authors, :approval_status
  end

end

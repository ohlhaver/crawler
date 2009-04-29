class AddColumnsForCrawlers < ActiveRecord::Migration
  def self.up
    add_column :sources,   :last_story_at, :datetime
    add_column :feedpages, :last_story_at, :datetime
    add_column :feedpages, :story_count, :integer, :limit => 11, :null => false, :default => 0
    Feedpage.update_all("story_count = previous_size")
  end

  def self.down
  end
end

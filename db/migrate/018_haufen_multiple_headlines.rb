class HaufenMultipleHeadlines < ActiveRecord::Migration
  def self.up
    add_column :haufens, :top_story_ids, :string, :null => false, :default => ''
  end

  def self.down
  end
end

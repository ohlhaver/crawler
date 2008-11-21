class AddKeywordsColumnToRawstory < ActiveRecord::Migration
  def self.up
    add_column :rawstories, :keywords, :string
  end

  def self.down
    remove_column :rawstories, :keywords
  end
end

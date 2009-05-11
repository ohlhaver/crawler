class AddKeywordColumnToHaufens < ActiveRecord::Migration
  def self.up
    add_column :haufens, :keywords, :string, :null => false, :default => ''
  end

  def self.down
  end

end

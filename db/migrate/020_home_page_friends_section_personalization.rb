class HomePageFriendsSectionPersonalization < ActiveRecord::Migration
  def self.up
    add_column :home_page_confs, :friends_section_status, :integer, :null => false, :default => 0
  end

  def self.down
  end
end

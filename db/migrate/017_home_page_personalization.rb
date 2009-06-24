class HomePagePersonalization < ActiveRecord::Migration
  def self.up
    create_table :home_page_confs do |t|
      t.integer  :user_id,        :null => false, :default => 0
      t.integer  :top_stories_section_status, :null => false, :default => 0
      t.integer  :politics_section_status, :null => false, :default => 0
      t.integer  :business_section_status, :null => false, :default => 0
      t.integer  :culture_section_status, :null => false, :default => 0
      t.integer  :science_section_status, :null => false, :default => 0
      t.integer  :technology_section_status, :null => false, :default => 0
      t.integer  :sport_section_status, :null => false, :default => 0
      t.integer  :mixed_section_status, :null => false, :default => 0
      t.integer  :opinions_section_status, :null => false, :default => 0
      t.integer  :my_authors_section_status, :null => false, :default => 0
      t.integer  :my_topics_section_status, :null => false, :default => 0
      t.timestamps
    end
    add_index :home_page_confs, [:user_id], :name => "index_home_page_confs_on_user_id"

    #############################################
    # Create records for existing users
    #############################################
    User.find(:all).each do |u|
      HomePageConf.create!(:user_id => u.id)
    end
  end

  def self.down
  end
end

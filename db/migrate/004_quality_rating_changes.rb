class QualityRatingChanges < ActiveRecord::Migration
  def self.up
    create_table :rawstory_details do |t|
      t.integer :rawstory_id,       :limit => 11, :null => false
      t.integer :quality,           :limit => 11, :null => false, :default => JConst::Quality::HIGH
      t.integer :subscription_type, :limit => 11, :null => false, :default => JConst::SubscriptionType::FREE_LOGIN_NOT_NEEDED
      t.timestamps
    end
    add_index :rawstory_details, [:rawstory_id], :name => "index_rawstory_details_on_rawstory_id"

    add_column :feedpages, :quality, :integer, :limit => 11, :null => false, :default => JConst::Quality::HIGH
    add_column :feedpages, :subscription_type, :integer, :limit => 11, :null => false, :default => JConst::SubscriptionType::FREE_LOGIN_NOT_NEEDED
    add_column :sources, :quality, :integer, :limit => 11, :null => false, :default => JConst::Quality::HIGH
    add_column :sources, :subscription_type, :integer, :limit => 11, :null => false, :default => JConst::SubscriptionType::FREE_LOGIN_NOT_NEEDED

    # Populate rawstory_details table
    execute("insert into rawstory_details (rawstory_id) select rawstories.id from rawstories")
    video_pages = Feedpage.find(:all, :conditions => ["video = ?", true], :select => "id")
    video_page_ids = video_pages.collect{|p| p.id}*","
    unless video_page_ids.blank?
      Feedpage.update_all(["quality = #{JConst::Quality::MEDIUM}"],["id IN ( #{video_page_ids} )"])
      execute("update rawstory_details r1, rawstories r set r1.quality = #{JConst::Quality::MEDIUM} where r1.rawstory_id = r.id and r.feedpage_id IN ( #{video_page_ids} )")
    end
  end

  def self.down
    #drop_table :rawstory_details
  end
end

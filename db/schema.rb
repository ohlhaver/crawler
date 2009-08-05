# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 22) do

  create_table "author_maps", :force => true do |t|
    t.integer  "author_id",        :limit => 11
    t.integer  "unique_author_id", :limit => 11
    t.integer  "status",           :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "author_maps", ["status"], :name => "index_author_maps_on_status"
  add_index "author_maps", ["author_id"], :name => "index_author_maps_on_author_id"
  add_index "author_maps", ["unique_author_id"], :name => "index_author_maps_on_unique_author_id"

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "opinionated",     :limit => 11
    t.integer  "approval_status", :limit => 11, :default => 0
  end

  add_index "authors", ["name"], :name => "index_authors_on_name"
  add_index "authors", ["approval_status"], :name => "index_authors_on_approval_status"

  create_table "duplicate_groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eintrags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration",   :limit => 11
    t.integer  "level",      :limit => 11
  end

  create_table "feedpage_health_metrics", :force => true do |t|
    t.integer  "feedpage_id",     :limit => 11,                :null => false
    t.integer  "source_id",       :limit => 11,                :null => false
    t.integer  "metric_type",     :limit => 11,                :null => false
    t.integer  "title_count",     :limit => 11, :default => 0, :null => false
    t.integer  "author_count",    :limit => 11, :default => 0, :null => false
    t.integer  "body_count",      :limit => 11, :default => 0, :null => false
    t.integer  "week_count",      :limit => 11, :default => 0, :null => false
    t.datetime "calculated_from",                              :null => false
    t.datetime "calculated_upto",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedpage_health_metrics", ["feedpage_id"], :name => "index_feedpage_health_metrics_on_feedpage_id"
  add_index "feedpage_health_metrics", ["source_id"], :name => "index_feedpage_health_metrics_on_source_id"
  add_index "feedpage_health_metrics", ["metric_type"], :name => "index_feedpage_health_metrics_on_metric_type"

  create_table "feedpages", :force => true do |t|
    t.string   "url"
    t.string   "publication"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id",         :limit => 11
    t.integer  "Active",            :limit => 11
    t.integer  "previous_size",     :limit => 11
    t.integer  "opinionated",       :limit => 11
    t.integer  "language",          :limit => 11
    t.integer  "topic",             :limit => 11
    t.boolean  "video"
    t.datetime "last_story_at"
    t.integer  "story_count",       :limit => 11, :default => 0, :null => false
    t.integer  "quality",           :limit => 11, :default => 3, :null => false
    t.integer  "subscription_type", :limit => 11, :default => 0, :null => false
  end

  create_table "groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight",      :limit => 11
    t.integer  "pilot",       :limit => 11
    t.integer  "topic",       :limit => 11
    t.integer  "gsession_id", :limit => 11
    t.integer  "broadness",   :limit => 11
    t.integer  "language",    :limit => 11
  end

  create_table "gsessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "haufens", :force => true do |t|
    t.integer  "weight",         :limit => 11
    t.integer  "pilot",          :limit => 11
    t.integer  "topic",          :limit => 11
    t.integer  "hsession_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "members"
    t.integer  "latest",         :limit => 11
    t.integer  "broadness",      :limit => 11
    t.integer  "language",       :limit => 11
    t.integer  "videos",         :limit => 11
    t.string   "keywords",                     :default => "",    :null => false
    t.boolean  "image_exists",                 :default => false, :null => false
    t.integer  "image_story_id", :limit => 11, :default => 0,     :null => false
    t.string   "top_story_ids",                :default => "",    :null => false
  end

  create_table "haufens_story_images", :force => true do |t|
    t.integer  "haufen_id",      :limit => 11, :default => 0, :null => false
    t.integer  "story_image_id", :limit => 11, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "haufens_story_images", ["haufen_id"], :name => "index_haufens_story_images_on_haufen_id"
  add_index "haufens_story_images", ["story_image_id"], :name => "index_haufens_story_images_on_story_image_id"

  create_table "home_page_confs", :force => true do |t|
    t.integer  "user_id",                    :limit => 11, :default => 0, :null => false
    t.integer  "top_stories_section_status", :limit => 11, :default => 0, :null => false
    t.integer  "politics_section_status",    :limit => 11, :default => 0, :null => false
    t.integer  "business_section_status",    :limit => 11, :default => 0, :null => false
    t.integer  "culture_section_status",     :limit => 11, :default => 0, :null => false
    t.integer  "science_section_status",     :limit => 11, :default => 0, :null => false
    t.integer  "technology_section_status",  :limit => 11, :default => 0, :null => false
    t.integer  "sport_section_status",       :limit => 11, :default => 0, :null => false
    t.integer  "mixed_section_status",       :limit => 11, :default => 0, :null => false
    t.integer  "opinions_section_status",    :limit => 11, :default => 0, :null => false
    t.integer  "my_authors_section_status",  :limit => 11, :default => 0, :null => false
    t.integer  "my_topics_section_status",   :limit => 11, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "friends_section_status",     :limit => 11, :default => 0, :null => false
  end

  add_index "home_page_confs", ["user_id"], :name => "index_home_page_confs_on_user_id"

  create_table "hsessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "olists", :force => true do |t|
    t.text     "en"
    t.text     "de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "all"
  end

  create_table "profile_actions", :force => true do |t|
    t.integer  "user_id",          :limit => 11, :default => 0,  :null => false
    t.integer  "action_type",      :limit => 11, :default => 0,  :null => false
    t.integer  "entity_id",        :limit => 11, :default => 0,  :null => false
    t.string   "entity_type",                    :default => "", :null => false
    t.string   "entity_content",                 :default => "", :null => false
    t.integer  "receiver_user_id", :limit => 11, :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_actions", ["user_id"], :name => "index_profile_actions_on_user_id"
  add_index "profile_actions", ["entity_id"], :name => "index_profile_actions_on_entity_id"
  add_index "profile_actions", ["created_at"], :name => "index_profile_actions_on_created_at"

  create_table "profile_notifications", :force => true do |t|
    t.integer  "user_id",           :limit => 11, :default => 0,    :null => false
    t.integer  "notification_type", :limit => 11, :default => 0,    :null => false
    t.integer  "entity_id",         :limit => 11, :default => 0,    :null => false
    t.string   "entity_type",                     :default => "",   :null => false
    t.string   "entity_content",                  :default => "",   :null => false
    t.boolean  "active",                          :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_notifications", ["user_id"], :name => "index_profile_notifications_on_user_id"
  add_index "profile_notifications", ["entity_id"], :name => "index_profile_notifications_on_entity_id"
  add_index "profile_notifications", ["created_at"], :name => "index_profile_notifications_on_created_at"

  create_table "rawstories", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id",   :limit => 11
    t.integer  "feedpage_id", :limit => 11
    t.integer  "source_id",   :limit => 11
    t.integer  "opinion",     :limit => 11
    t.integer  "language",    :limit => 11
    t.integer  "group_id",    :limit => 11
    t.integer  "haufen_id",   :limit => 11
    t.string   "keywords"
    t.integer  "titlehash",   :limit => 11
    t.integer  "linkhash",    :limit => 11
    t.boolean  "video"
    t.integer  "hscore",      :limit => 11
    t.integer  "nhaufen",     :limit => 11
  end

  add_index "rawstories", ["title"], :name => "index_rawstories_on_title", :unique => true
  add_index "rawstories", ["link"], :name => "index_rawstories_on_link", :unique => true

  create_table "rawstories_story_images", :force => true do |t|
    t.integer  "rawstory_id",    :limit => 11, :default => 0, :null => false
    t.integer  "story_image_id", :limit => 11, :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rawstories_story_images", ["rawstory_id"], :name => "index_rawstories_story_images_on_rawstory_id"
  add_index "rawstories_story_images", ["story_image_id"], :name => "index_rawstories_story_images_on_story_image_id"

  create_table "rawstory_details", :force => true do |t|
    t.integer  "rawstory_id",        :limit => 11,                    :null => false
    t.integer  "quality",            :limit => 11, :default => 3,     :null => false
    t.integer  "subscription_type",  :limit => 11, :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duplicate_group_id", :limit => 11, :default => 1,     :null => false
    t.boolean  "is_duplicate",                     :default => false, :null => false
    t.boolean  "image_exists",                     :default => false, :null => false
  end

  add_index "rawstory_details", ["rawstory_id"], :name => "index_rawstory_details_on_rawstory_id"
  add_index "rawstory_details", ["duplicate_group_id"], :name => "index_rawstory_details_on_duplicate_group_id"

  create_table "read_items", :force => true do |t|
    t.integer  "user_id",     :limit => 11, :null => false
    t.integer  "rawstory_id", :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "read_items", ["user_id"], :name => "index_read_items_on_user_id"
  add_index "read_items", ["rawstory_id"], :name => "index_read_items_on_rawstory_id"

  create_table "recommendations", :force => true do |t|
    t.integer  "recommender_id", :limit => 11, :default => 0,    :null => false
    t.integer  "user_id",        :limit => 11, :default => 0,    :null => false
    t.integer  "resource_id",    :limit => 11, :default => 0,    :null => false
    t.string   "resource_type",                :default => "",   :null => false
    t.string   "message",                      :default => "",   :null => false
    t.boolean  "active",                       :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendations", ["recommender_id"], :name => "index_recommendations_on_recommender_id"
  add_index "recommendations", ["user_id"], :name => "index_recommendations_on_user_id"
  add_index "recommendations", ["resource_id"], :name => "index_recommendations_on_resource_id"

  create_table "site_map_author_categories", :force => true do |t|
    t.string "label"
  end

  create_table "site_map_author_sub_categories", :force => true do |t|
    t.string  "label"
    t.integer "category_id", :limit => 11
  end

  add_index "site_map_author_sub_categories", ["category_id"], :name => "index_site_map_author_sub_categories_on_category_id"

  create_table "site_map_category_author_maps", :force => true do |t|
    t.integer "author_id",       :limit => 11
    t.integer "sub_category_id", :limit => 11
    t.integer "category_id",     :limit => 11
  end

  add_index "site_map_category_author_maps", ["author_id"], :name => "index_site_map_category_author_maps_on_author_id"
  add_index "site_map_category_author_maps", ["sub_category_id"], :name => "index_site_map_category_author_maps_on_sub_category_id"
  add_index "site_map_category_author_maps", ["category_id"], :name => "index_site_map_category_author_maps_on_category_id"

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_story_at"
    t.integer  "quality",           :limit => 11, :default => 3, :null => false
    t.integer  "subscription_type", :limit => 11, :default => 0, :null => false
  end

  create_table "story_images", :force => true do |t|
    t.string   "baseurl",                          :default => "",    :null => false
    t.integer  "source_id",          :limit => 11, :default => 0,     :null => false
    t.boolean  "image_exists",                     :default => false, :null => false
    t.string   "content_type",                     :default => "",    :null => false
    t.string   "dimensions",                       :default => "",    :null => false
    t.string   "thumb_dimensions",                 :default => "",    :null => false
    t.string   "thumb_content_type",               :default => "",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_images", ["created_at"], :name => "index_story_images_on_created_at"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.integer  "author_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unique_authors", :force => true do |t|
    t.string   "name"
    t.integer  "opinionated", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",                     :limit => 40
    t.string   "salt",                                 :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",                      :limit => 40
    t.datetime "activated_at"
    t.text     "stories"
    t.text     "new_stories"
    t.boolean  "alerts"
    t.string   "searchterms"
    t.boolean  "full"
    t.integer  "language",                             :limit => 11
    t.integer  "fb_user_id",                           :limit => 20
    t.string   "email_hash",                                         :default => "",    :null => false
    t.string   "name",                                               :default => "",    :null => false
    t.string   "fb_session_key",                                     :default => "",    :null => false
    t.boolean  "fb_offline_access_permission_granted",               :default => false, :null => false
    t.boolean  "fb_email_permission_granted",                        :default => false, :null => false
    t.boolean  "jurnalo_user",                                       :default => true,  :null => false
    t.datetime "last_alert_at"
    t.integer  "alert_type",                           :limit => 11, :default => 1,     :null => false
  end

  add_index "users", ["fb_user_id"], :name => "index_users_on_fb_user_id"
  add_index "users", ["email_hash"], :name => "index_users_on_email_hash"

end

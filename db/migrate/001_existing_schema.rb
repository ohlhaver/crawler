class ExistingSchema < ActiveRecord::Migration
  def self.up
    ######################################
    # Start : table authors
    ######################################
    create_table :authors do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :opinionated,  :limit => 11

    end
    add_index :authors, [:name], :name => "index_authors_on_name"
    ######################################
    # End : table authors
    ######################################

    ######################################
    # Start : table eintrags
    ######################################
    create_table :eintrags do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :duration,   :limit => 11
      t.integer  :level,      :limit => 11
    end
    ######################################
    # End : table eintrags
    ######################################
    ######################################
    # Start : table feedpages
    ######################################
    create_table :feedpages do |t|
      t.string   :url
      t.string   :publication
      t.string   :website
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :source_id, :limit => 11
      t.integer  :Active,  :limit => 11
      t.integer  :previous_size, :limit => 11
      t.integer  :opinionated,  :limit => 11
      t.integer  :language,    :limit => 11
      t.integer  :topic,       :limit => 11
      t.boolean  :video
    end

    add_index :feedpages, [:source_id], :name => "index_feedpages_on_source_id"
    ######################################
   # End   : table feedpages
    ######################################

    ######################################
    # Start : table groups
    ######################################

    create_table :groups do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :weight,       :limit => 11
      t.integer  :pilot,        :limit => 11
      t.integer  :topic,        :limit => 11
      t.integer  :gsession_id, :limit => 11
      t.integer  :broadness,   :limit => 11
      t.integer  :language,    :limit => 11
    end

    add_index :groups, [:gsession_id], :name => "index_groups_on_gsession_id"

    ######################################
    # End   : table groups
    ######################################

    ######################################
    # Start : table gsessions
    ######################################
    create_table :gsessions do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
    ######################################
    # End   : table gsessions
    ######################################

    ######################################
    # Start : table haufens
    ######################################
    create_table :haufens do |t|
      t.integer  :weight,      :limit => 11
      t.integer  :pilot,       :limit => 11
      t.integer  :topic,       :limit => 11
      t.integer  :hsession_id, :limit => 11 
      t.datetime :created_at
      t.datetime :updated_at
      t.text     :members
      t.integer  :latest,      :limit => 11
      t.integer  :broadness,   :limit => 11
      t.integer  :language,    :limit => 11
      t.integer  :videos,      :limit => 11
    end

    add_index :haufens, [:hsession_id], :name => "index_haufens_on_hsession_id"
    ######################################
    # End   : table haufens
    ######################################

    ######################################
    # Start : table hsessions
    ######################################
    create_table :hsessions do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
    ######################################
    # End  : table hsessions
    ######################################

    ######################################
    # Start : table olists
    ######################################
    create_table :olists do |t|
      t.text     :en
      t.text     :de
      t.datetime :created_at
      t.datetime :updated_at
      t.text     :all
    end

    ######################################
    # End   : table olists
    ######################################
    
    ######################################
    # Start : table rawstories
    ######################################

    create_table :rawstories do |t|
      t.string   :title
      t.string   :link
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :author_id,   :limit => 11  
      t.integer  :feedpage_id, :limit => 11  # -- ditto
      t.integer  :source_id,   :limit => 11  # -- ditto
      t.integer  :opinion    
      t.integer  :language,    :limit => 11
      t.integer  :group_id,    :limit => 11
      t.integer  :haufen_id,   :limit => 11
      t.string   :keywords
      t.boolean  :video
      t.integer  :hscore,   :limit => 11
    end

    add_index :rawstories, [:title],     :name => "index_rawstories_on_title", :unique => true # columns have null values !!! 
    add_index :rawstories, [:link],      :name => "index_rawstories_on_link", :unique => true
    add_index :rawstories, [:author_id], :name => "index_rawstories_on_author_id"
    add_index :rawstories, [:haufen_id], :name => "index_rawstories_on_haufen_id"
    ######################################
    # End : table rawstories
    ######################################

    ######################################
    # Start : table sources
    ######################################
    create_table :sources do |t|
      t.string   :name
      t.string   :website
      t.datetime :created_at
      t.datetime :updated_at
    end
    ######################################
    # End   : table sources
    ######################################

    ######################################
    # Start : table subscriptions
    ######################################
    create_table :subscriptions do |t|
      t.integer  :user_id,   :limit => 11
      t.integer  :author_id,  :limit => 11
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :subscriptions, [:author_id], :name => "index_subscriptions_on_author_id"
    add_index :subscriptions, [:user_id], :name => "index_subscriptions_on_user_id"
    ######################################
    # End : table subscriptions
    ######################################

    ######################################
    # Start : table users
    ######################################

    create_table :users do |t|
      t.string   :login
      t.string   :email
      t.string   :crypted_password, :limit => 40 # there is one row with NULL value
      t.string   :salt, :limit => 40             # -- ditto
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :activation_code,           :limit => 40
      t.datetime :activated_at
      t.text     :stories
      t.text     :new_stories
      t.boolean     :alerts
      t.string   :searchterms
      t.integer  :language,                  :limit => 11
    end
    ######################################
    # End   : table users
    ######################################


  end

  def self.down
  end
end

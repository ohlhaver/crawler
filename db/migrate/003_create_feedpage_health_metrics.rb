class CreateFeedpageHealthMetrics < ActiveRecord::Migration
  def self.up
    create_table :feedpage_health_metrics do |t|
      t.integer  :feedpage_id, :limit => 11, :null => false
      t.integer  :source_id, :limit => 11, :null => false
      t.integer  :metric_type, :limit => 11, :null => false
      t.integer  :title_count, :limit => 11, :null => false, :default => 0
      t.integer  :author_count, :limit => 11, :null => false, :default => 0
      t.integer  :body_count, :limit => 11, :null => false, :default => 0
      t.integer  :week_count, :limit => 11, :null => false, :default => 0
      t.datetime :calculated_from, :null => false
      t.datetime :calculated_upto, :null => false
      t.timestamps
    end
    add_index :feedpage_health_metrics, [:feedpage_id], :name => "index_feedpage_health_metrics_on_feedpage_id"
    add_index :feedpage_health_metrics, [:source_id], :name => "index_feedpage_health_metrics_on_source_id"
    add_index :feedpage_health_metrics, [:metric_type], :name => "index_feedpage_health_metrics_on_metric_type"
    
    # Populating records for existing feedpages
    calculated_upto_monday = (Time.now - 7.days).monday
    Feedpage.find(:all).each do |page|
      page.create_health_metrics(calculated_upto_monday)
    end
  end

  def self.down
    #drop_table :feedpage_health_metrics
  end
end

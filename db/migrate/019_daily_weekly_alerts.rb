class DailyWeeklyAlerts < ActiveRecord::Migration
  def self.up
    add_column :users, :last_alert_at, :datetime
    add_column :users, :alert_type, :integer, :null => false, :default => User::Alert::IMMEDIATE # = 1
    User.find(:all).each do |u|
      unless u.alerts
        u.alert_type = User::Alert::OFF      
        u.save!
      end
    end

  end

  def self.down
  end
end

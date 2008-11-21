class AddDurationColumnToEintrag < ActiveRecord::Migration
  def self.up
    add_column :eintrags, :duration, :integer
    add_column :eintrags, :level, :integer
  end

  def self.down
    remove_column :eintrags, :duration
    remove_column :eintrags, :level
  end
end

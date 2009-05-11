class UpdateColumnTypeAuthorSwiper < ActiveRecord::Migration
  def self.up
    change_column :authors, :approval_status, :integer, :default => 0
    change_column :author_maps, :status, :integer, :default => 0
  end

  def self.down
  end
end

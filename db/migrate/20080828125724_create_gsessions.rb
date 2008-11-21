class CreateGsessions < ActiveRecord::Migration
  def self.up
    create_table :gsessions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :gsessions
  end
end

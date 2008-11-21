class CreateHsessions < ActiveRecord::Migration
  def self.up
    create_table :hsessions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :hsessions
  end
end

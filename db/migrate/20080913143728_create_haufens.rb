class CreateHaufens < ActiveRecord::Migration
  def self.up
    create_table :haufens do |t|
      t.integer :weight
      t.integer :pilot
      t.integer :topic
      t.integer :hsession_id

      t.timestamps
    end
  end

  def self.down
    drop_table :haufens
  end
end

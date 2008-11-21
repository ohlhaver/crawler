class CreateOlists < ActiveRecord::Migration
  def self.up
    create_table :olists do |t|
      t.text :en
      t.text :de

      t.timestamps
    end
  end

  def self.down
    drop_table :olists
  end
end

class CreateShips < ActiveRecord::Migration
  def self.up
    create_table :ships do |t|
      t.string :name
      t.integer :attack
      t.integer :capacity
      t.integer :robspeed
      t.string :img_url
	  t.text :intro
      t.timestamps
    end
  end

  def self.down
    drop_table :ships
  end
end

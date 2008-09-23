class CreateUserships < ActiveRecord::Migration
  def self.up
    create_table :userships do |t|
      t.string :name
      t.integer :attack
      t.integer :capacity
      t.integer :robspeed
      t.integer :user_id
      t.date :revivaltime
      t.timestamps
    end
  end

  def self.down
    drop_table :userships
  end
end

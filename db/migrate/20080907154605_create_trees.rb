class CreateTrees < ActiveRecord::Migration
  def self.up
    create_table :trees do |t|
      t.integer :state
      t.integer :user_id
      t.integer :level
      t.datetime :produce_time

      t.timestamps
    end
  end

  def self.down
    drop_table :trees
  end
end

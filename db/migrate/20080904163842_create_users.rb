class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :xid
      t.text :friend_ids
      t.integer :gold
      t.integer :pgold
      t.date :bship_ftime
      t.boolean :admin
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

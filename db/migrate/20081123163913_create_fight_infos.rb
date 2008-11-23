class CreateFightInfos < ActiveRecord::Migration
  def self.up
    create_table :fight_infos do |t|
      t.integer :user_id
      t.integer :from_xid
      t.integer :to_xid
      t.boolean :won
	  t.integer :money
	  
      t.timestamps
    end
	add_index :fight_infos, :user_id
  end

  def self.down
    drop_table :fight_infos
  end
end

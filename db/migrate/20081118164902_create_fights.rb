class CreateFights < ActiveRecord::Migration
  def self.up
    create_table :fights do |t|
      t.integer :attack
      t.string :ship_ids
	  t.integer :thew
	  t.integer :maxthew
	  t.integer :user_id
	  t.boolean :fighted
	  t.integer :ship_count
	  t.datetime :last_add_thew
	  t.boolean :death_mode

      t.timestamps
    end
	add_index :fights, :user_id
	add_index :fights, :attack
	add_index :fights, :ship_count
  end

  def self.down
    drop_table :fights
  end
end

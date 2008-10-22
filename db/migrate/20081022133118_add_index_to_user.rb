class AddIndex < ActiveRecord::Migration
  def self.up
  add_index :users, :captain_master 
  add_index :users, :captain_price 
  add_index :users, :captain_level 
  add_index :users, :captain_usership_id
  end

  def self.down
  remove_index :users, :captain_master 
  remove_index :users, :captain_price 
  remove_index :users, :captain_level 
  remove_index :users, :captain_usership_id
  end
end

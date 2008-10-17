class AddCaptainToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :captain_master, :string
    add_column :users, :captain_level, :integer
    add_column :users, :captain_exp, :integer
    add_column :users, :captain_aexp, :integer
    add_column :users, :captain_price, :integer
    add_column :users, :captain_capacity, :integer
    add_column :users, :captain_robspeed, :integer
    add_column :users, :captain_attack, :integer
    add_column :users, :captain_lattribute, :integer
    add_column :users, :captain_usership_id, :integer
	add_column :users, :captain_sell_count, :integer
	add_column :users, :captain_sell_updated_at, :datatime
  end

  def self.down
    remove_column :users, :captain_usership_id
    remove_column :users, :captain_lattribute
    remove_column :users, :captain_attack
    remove_column :users, :captain_robspeed
    remove_column :users, :captain_capacity
    remove_column :users, :captain_price
    remove_column :users, :captain_aexp
    remove_column :users, :captain_exp
    remove_column :users, :captain_level
    remove_column :users, :captain_master
	remove_column :users, :captain_sell_count
	remove_column :users, :captain_sell_updated_at
  end
end

class AddIndexToUserAndNotice < ActiveRecord::Migration
  def self.up
  add_index :notices, [:from_xid,:to_xid,:ltype]
  add_index :users, :captain_sell_count
  end

  def self.down
  remove_index :notices, [:from_xid,:to_xid,:ltype]
  remove_index :users, :captain_sell_count
  end
end

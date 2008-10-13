class AddIndexToNotices < ActiveRecord::Migration
  def self.up
  add_index :notices, :from_xid
  add_index :notices, :to_xid
  end

  def self.down
  remove_index :notices, :from_xid 
  remove_index :notices, :to_xid 
  end
end

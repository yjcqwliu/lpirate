class AddIndex < ActiveRecord::Migration
  def self.up
  add_index :users, :xid 
  add_index :users, :updated_at 
  add_index :users, :gold 
  add_index :notices, [:from_xid,:to_xid] 
  add_index :notices, :ltype 
  add_index :userships, :user_id 
  end

  def self.down
  remove_index :users, :xid 
  remove_index :users, :updated_at 
  remove_index :users, :gold 
  remove_index :notices, [:from_xid,:to_xid] 
  remove_index :notices, :ltype 
  remove_index :userships, :user_id 
  end
end

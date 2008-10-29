class ChangeIndexToNotices < ActiveRecord::Migration
  def self.up
  remove_index :notices, [:from_xid,:to_xid]
  remove_index :notices, :to_xid
  add_index :notices, [:to_xid,:from_xid]
  remove_column :notices, :content
  add_column :notices, :column1 ,:string
  add_column :notices, :column2 ,:string
  end

  def self.down
  add_index :notices, [:from_xid,:to_xid]
  add_index :notices, :to_xid
  remove_index :notices, [:to_xid,:from_xid]
  add_column :notices, :content ,:text
  remove_column :notices, :column1 ,:string
  remove_column :notices, :column2 ,:string
  end
end

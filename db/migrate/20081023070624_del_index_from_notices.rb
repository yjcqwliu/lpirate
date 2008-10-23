class DelIndexFromNotices < ActiveRecord::Migration
  def self.up
	  remove_index :notices, :ltype
	  add_index :notices, :user_id
  end

  def self.down
      add_index :notices, :ltype
	  remove_index :notices, :user_id
  end
end

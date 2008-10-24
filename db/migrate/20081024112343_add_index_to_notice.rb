class AddIndexToNotice < ActiveRecord::Migration
  def self.up
  add_index :notices, [:sented,:noticed]
  end

  def self.down
  remove_index :notices, [:sented,:noticed]
  end
end

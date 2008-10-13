class AddIndexUpdatedAtToNotices < ActiveRecord::Migration
  def self.up
  add_index :notices, :updated_at
  end

  def self.down
  remove_index :notices, :updated_at
  end
end

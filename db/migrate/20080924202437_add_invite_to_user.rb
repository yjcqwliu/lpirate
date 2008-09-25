class AddInviteToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :invite, :text
  end

  def self.down
    remove_column :users, :invite
  end
end

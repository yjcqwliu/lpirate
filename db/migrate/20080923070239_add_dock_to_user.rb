class AddDockToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :dock1, :integer
    add_column :users, :dock2, :integer
    add_column :users, :dock3, :integer
    add_column :users, :dock4, :integer
    add_column :users, :dock1_time, :datetime
    add_column :users, :dock2_time, :datetime
    add_column :users, :dock3_time, :datetime
    add_column :users, :dock4_time, :datetime
  end

  def self.down
    remove_column :users, :dock4_time
    remove_column :users, :dock3_time
    remove_column :users, :dock2_time
    remove_column :users, :dock1_time
    remove_column :users, :dock4
    remove_column :users, :dock3
    remove_column :users, :dock2
    remove_column :users, :dock1
  end
end

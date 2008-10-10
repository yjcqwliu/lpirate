class AddBusinessToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :business_level, :integer
    add_column :users, :business_top, :integer
    add_column :users, :business_count, :integer
    add_column :users, :business_update_at, :datetime
    add_column :users, :business_exp, :integer
    add_column :users, :award_updated_at, :datetime
  end

  def self.down
    remove_column :users, :award_updated_at
    remove_column :users, :business_exp
    remove_column :users, :business_update_at
    remove_column :users, :business_count
    remove_column :users, :business_top
    remove_column :users, :business_level
  end
end

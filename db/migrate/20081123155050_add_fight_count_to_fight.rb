class AddFightCountToFight < ActiveRecord::Migration
  def self.up
    add_column :fights, :total_count, :integer
	add_column :fights, :win_count, :integer
	add_column :fights, :win_percent, :float
	add_index :fights, [:win_percent, :total_count]
  end

  def self.down
    remove_column :fights, :total_count
	remove_column :fights, :win_count
	remove_column :fights, :win_percent
  end
end

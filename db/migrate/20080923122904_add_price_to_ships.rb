class AddPriceToShips < ActiveRecord::Migration
  def self.up
    add_column :ships, :price, :integer
  end

  def self.down
    remove_column :ships, :price
  end
end

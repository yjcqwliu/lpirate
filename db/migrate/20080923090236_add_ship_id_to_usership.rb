class AddShipIdToUsership < ActiveRecord::Migration
  def self.up
    add_column :userships, :ship_id, :integer
  end

  def self.down
    remove_column :userships, :ship_id
  end
end

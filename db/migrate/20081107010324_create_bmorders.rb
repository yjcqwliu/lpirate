class CreateBmorders < ActiveRecord::Migration
  def self.up
    create_table :bmorders do |t|
      t.string :uid
      t.integer :money
      t.string :info
      t.integer :orderid
      t.string :sign

      t.timestamps
    end
	add_index :bmorders, :uid
	add_index :bmorders, :orderid
	add_index :bmorders, :updated_at
  end

  def self.down
    drop_table :bmorders
  end
end

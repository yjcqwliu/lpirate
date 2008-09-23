class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :from_id
      t.integer :from_xid

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end

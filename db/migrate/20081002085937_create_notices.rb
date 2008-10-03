class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      t.integer :user_id
      t.string :from_xid
      t.text :content
      t.string :to_xid
      t.boolean :sented
      t.boolean :noticed
      t.integer :ltype

      t.timestamps
    end
  end

  def self.down
    drop_table :notices
  end
end

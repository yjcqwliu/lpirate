class CreateTmpFriendIds < ActiveRecord::Migration
  def self.up
    create_table :tmpf do |t|
      t.string :fid
      t.string :tid

      t.timestamps
    end
  end

  def self.down
    drop_table :tmpf
  end
end

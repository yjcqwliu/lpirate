class CreateUserassignments < ActiveRecord::Migration
  def self.up
    create_table :userassignments do |t|
      t.integer :assignment_id
      t.integer :user_id
      t.boolean :state

      t.timestamps
    end
  end

  def self.down
    drop_table :userassignments
  end
end

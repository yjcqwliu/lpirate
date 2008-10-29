class ChangeIndexToNotices < ActiveRecord::Migration
  def self.up
  create_table :notices, :force => true do |t|
    t.integer  "user_id"
    t.string   "from_xid"
    t.string   "to_xid"
    t.boolean  "sented"
    t.boolean  "noticed"
    t.integer  "ltype"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "column1"
    t.string   "column2"
  end

  add_index "notices", ["from_xid"], :name => "index_notices_on_from_xid"
  add_index "notices", ["updated_at"], :name => "index_notices_on_updated_at"
  add_index "notices", ["user_id"], :name => "index_notices_on_user_id"
  add_index "notices", ["to_xid", "from_xid"], :name => "index_notices_on_to_xid_and_from_xid"

  def self.down
  drop_table :notices
  end
end

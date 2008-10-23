# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081023070624) do

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "from_id"
    t.integer  "from_xid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", :force => true do |t|
    t.integer  "user_id"
    t.string   "from_xid"
    t.text     "content"
    t.string   "to_xid"
    t.boolean  "sented"
    t.boolean  "noticed"
    t.integer  "ltype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notices", ["from_xid", "to_xid"], :name => "index_notices_on_from_xid_and_to_xid"
  add_index "notices", ["from_xid"], :name => "index_notices_on_from_xid"
  add_index "notices", ["to_xid"], :name => "index_notices_on_to_xid"
  add_index "notices", ["updated_at"], :name => "index_notices_on_updated_at"
  add_index "notices", ["user_id"], :name => "index_notices_on_user_id"

  create_table "ships", :force => true do |t|
    t.string   "name"
    t.integer  "attack"
    t.integer  "capacity"
    t.integer  "robspeed"
    t.string   "img_url"
    t.text     "intro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
  end

  create_table "trees", :force => true do |t|
    t.integer  "state"
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "produce_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userassignments", :force => true do |t|
    t.integer  "assignment_id"
    t.integer  "user_id"
    t.boolean  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "xid"
    t.text     "friend_ids"
    t.integer  "gold"
    t.integer  "pgold"
    t.date     "bship_ftime"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dock1"
    t.integer  "dock2"
    t.integer  "dock3"
    t.integer  "dock4"
    t.datetime "dock1_time"
    t.datetime "dock2_time"
    t.datetime "dock3_time"
    t.datetime "dock4_time"
    t.string   "session_key"
    t.text     "invite"
    t.integer  "business_level"
    t.integer  "business_top"
    t.integer  "business_count"
    t.datetime "business_update_at"
    t.integer  "business_exp"
    t.datetime "award_updated_at"
    t.string   "captain_master"
    t.integer  "captain_level"
    t.integer  "captain_exp"
    t.integer  "captain_aexp"
    t.integer  "captain_price"
    t.integer  "captain_capacity"
    t.integer  "captain_robspeed"
    t.integer  "captain_attack"
    t.integer  "captain_lattribute"
    t.integer  "captain_usership_id"
    t.integer  "captain_sell_count"
    t.datetime "captain_sell_updated_at"
  end

  add_index "users", ["xid"], :name => "xid"
  add_index "users", ["xid"], :name => "index_users_on_xid"
  add_index "users", ["updated_at"], :name => "index_users_on_updated_at"
  add_index "users", ["gold"], :name => "index_users_on_gold"
  add_index "users", ["captain_master"], :name => "index_users_on_captain_master"
  add_index "users", ["captain_price"], :name => "index_users_on_captain_price"
  add_index "users", ["captain_level"], :name => "index_users_on_captain_level"
  add_index "users", ["captain_usership_id"], :name => "index_users_on_captain_usership_id"

  create_table "userships", :force => true do |t|
    t.string   "name"
    t.integer  "attack"
    t.integer  "capacity"
    t.integer  "robspeed"
    t.integer  "user_id"
    t.date     "revivaltime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ship_id"
    t.integer  "robof"
  end

  add_index "userships", ["user_id"], :name => "index_userships_on_user_id"

end

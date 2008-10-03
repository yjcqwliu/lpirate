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

ActiveRecord::Schema.define(:version => 20081002085937) do

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
  end

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

end

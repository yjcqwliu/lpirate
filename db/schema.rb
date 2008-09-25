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

ActiveRecord::Schema.define(:version => 20080924202437) do

  create_table "assignments", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id",    :limit => 11
    t.integer  "from_id",    :limit => 11
    t.integer  "from_xid",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ships", :force => true do |t|
    t.string   "name"
    t.integer  "attack",     :limit => 11
    t.integer  "capacity",   :limit => 11
    t.integer  "robspeed",   :limit => 11
    t.string   "img_url"
    t.text     "intro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price",      :limit => 11
  end

  create_table "trees", :force => true do |t|
    t.integer  "state",        :limit => 11
    t.integer  "user_id",      :limit => 11
    t.integer  "level",        :limit => 11
    t.datetime "produce_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userassignments", :force => true do |t|
    t.integer  "assignment_id", :limit => 11
    t.integer  "user_id",       :limit => 11
    t.boolean  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "xid"
    t.text     "friend_ids"
    t.integer  "gold",        :limit => 11
    t.integer  "pgold",       :limit => 11
    t.date     "bship_ftime"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dock1",       :limit => 11
    t.integer  "dock2",       :limit => 11
    t.integer  "dock3",       :limit => 11
    t.integer  "dock4",       :limit => 11
    t.datetime "dock1_time"
    t.datetime "dock2_time"
    t.datetime "dock3_time"
    t.datetime "dock4_time"
    t.string   "session_key"
    t.text     "invite"
  end

  create_table "userships", :force => true do |t|
    t.string   "name"
    t.integer  "attack",      :limit => 11
    t.integer  "capacity",    :limit => 11
    t.integer  "robspeed",    :limit => 11
    t.integer  "user_id",     :limit => 11
    t.date     "revivaltime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ship_id",     :limit => 11
    t.integer  "robof",       :limit => 11
  end

end

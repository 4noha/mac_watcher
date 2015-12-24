# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151225000001) do

  create_table "current_macs", force: :cascade do |t|
    t.string   "mac_address"
    t.string   "ip_address"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "current_macs", ["ip_address"], name: "index_current_macs_on_ip_address"
  add_index "current_macs", ["mac_address"], name: "index_current_macs_on_mac_address"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "io_logs", force: :cascade do |t|
    t.string   "ip_address"
    t.string   "mac_address"
    t.string   "io"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "io_logs", ["ip_address"], name: "index_io_logs_on_ip_address"
  add_index "io_logs", ["mac_address"], name: "index_io_logs_on_mac_address"

  create_table "named_lists", force: :cascade do |t|
    t.string   "ip_address"
    t.string   "mac_address"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "named_lists", ["ip_address"], name: "index_named_lists_on_ip_address"
  add_index "named_lists", ["mac_address"], name: "index_named_lists_on_mac_address"

end

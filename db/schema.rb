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

ActiveRecord::Schema.define(version: 20140227003944) do

  create_table "erasers", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "twitter_name", null: false
    t.string   "twitter_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "erasers", ["twitter_id"], name: "index_erasers_on_twitter_id"
  add_index "erasers", ["user_id", "twitter_id"], name: "index_erasers_on_user_id_and_twitter_id", unique: true

  create_table "remove_logs", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "eraser_id",  null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remove_logs", ["user_id", "eraser_id"], name: "index_remove_logs_on_user_id_and_eraser_id"

  create_table "users", force: true do |t|
    t.string   "nick"
    t.string   "uid"
    t.string   "access_token"
    t.string   "secret_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uid"], name: "index_users_on_uid", unique: true

end

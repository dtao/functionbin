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

ActiveRecord::Schema.define(version: 20131205163617) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.string   "parent_type", null: false
    t.integer  "parent_id",   null: false
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["parent_type", "parent_id"], name: "index_comments_on_parent_type_and_parent_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "functions", force: true do |t|
    t.integer  "user_id",                           null: false
    t.string   "name",                              null: false
    t.string   "description"
    t.text     "example",                           null: false
    t.integer  "implementations_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",        default: 0
  end

  add_index "functions", ["name"], name: "index_functions_on_name", unique: true
  add_index "functions", ["user_id"], name: "index_functions_on_user_id"

  create_table "implementations", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "function_id",                null: false
    t.text     "source",                     null: false
    t.integer  "score",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count", default: 0
  end

  add_index "implementations", ["function_id"], name: "index_implementations_on_function_id"
  add_index "implementations", ["user_id"], name: "index_implementations_on_user_id"

  create_table "upvotes", force: true do |t|
    t.integer  "user_id",           null: false
    t.integer  "implementation_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upvotes", ["implementation_id"], name: "index_upvotes_on_implementation_id"
  add_index "upvotes", ["user_id", "implementation_id"], name: "index_upvotes_on_user_id_and_implementation_id"

  create_table "users", force: true do |t|
    t.string   "name",                              null: false
    t.string   "email",                             null: false
    t.integer  "score",                 default: 0
    t.integer  "functions_count",       default: 0
    t.integer  "implementations_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

end

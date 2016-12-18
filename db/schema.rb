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

ActiveRecord::Schema.define(version: 20161218120832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountabilities", force: :cascade do |t|
    t.string   "type",                        null: false
    t.integer  "child_id",                    null: false
    t.string   "child_type",                  null: false
    t.integer  "parent_id",                   null: false
    t.string   "parent_type",                 null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_active",    default: true, null: false
    t.datetime "activated_at"
  end

  add_index "accountabilities", ["child_id", "child_type", "parent_id", "parent_type"], name: "index_accountabilities_on_parties", unique: true, using: :btree
  add_index "accountabilities", ["child_id"], name: "index_accountabilities_on_child_id", using: :btree
  add_index "accountabilities", ["child_type"], name: "index_accountabilities_on_child_type", using: :btree
  add_index "accountabilities", ["parent_id"], name: "index_accountabilities_on_parent_id", using: :btree
  add_index "accountabilities", ["parent_type"], name: "index_accountabilities_on_parent_type", using: :btree
  add_index "accountabilities", ["type"], name: "index_accountabilities_on_type", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "type",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_administator", default: false, null: false
  end

end

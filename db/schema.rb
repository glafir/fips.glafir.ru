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

ActiveRecord::Schema.define(version: 20150719124837) do

  create_table "fips_tzs", force: :cascade do |t|
    t.integer  "tz_n",              limit: 4,          null: false
    t.integer  "status",            limit: 4,          null: false
    t.string   "url_string_fips",   limit: 255
    t.text     "doc",               limit: 4294967295
    t.string   "org",               limit: 1000
    t.string   "img",               limit: 255
    t.string   "address_for_reply", limit: 255
    t.string   "country",           limit: 2
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fips_tzs", ["date_end"], name: "date_end", using: :btree
  add_index "fips_tzs", ["date_start"], name: "date_start", using: :btree
  add_index "fips_tzs", ["tz_n"], name: "tz_n", unique: true, using: :btree

  create_table "proxies", force: :cascade do |t|
    t.string   "proxy_address",  limit: 255, null: false
    t.integer  "proxy_port",     limit: 4,   null: false
    t.integer  "proxy_status",   limit: 4
    t.float    "proxy_timeout",  limit: 24
    t.string   "proxy_failures", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

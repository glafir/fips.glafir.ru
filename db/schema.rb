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

ActiveRecord::Schema.define(version: 20171225095813) do

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "country_name"
    t.string   "country_iata_code"
    t.string   "country_icao_code"
    t.integer  "country_number"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "fips_tzs", primary_key: "tz_n", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "status",                               null: false
    t.string   "url_string_fips",                      null: false
    t.text     "doc",               limit: 4294967295
    t.string   "org",               limit: 1000
    t.string   "img"
    t.string   "address_for_reply"
    t.string   "country",           limit: 2
    t.integer  "country_id"
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country"], name: "country", using: :btree
    t.index ["country_id"], name: "country_id", using: :btree
    t.index ["date_end"], name: "date_end", using: :btree
    t.index ["date_start"], name: "date_start", using: :btree
    t.index ["status"], name: "status", using: :btree
  end

  create_table "org_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "org_id"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "org_telefphones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "org_id"
    t.string   "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orgs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "shortname"
    t.string   "fullname"
    t.date     "create"
    t.integer  "org_state_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "proxies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "proxy_address",  limit: 15, null: false
    t.integer  "proxy_port",                null: false
    t.integer  "proxy_status"
    t.float    "proxy_timeout",  limit: 24
    t.string   "proxy_failures", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tz_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date_start"
    t.string   "doc"
    t.integer  "org_id"
    t.string   "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "useragent", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uagents", limit: 1000, null: false
  end

  create_table "useragents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uagents", limit: 1000, null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar"
    t.string   "time_zone"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "username", unique: true, using: :btree
  end

end

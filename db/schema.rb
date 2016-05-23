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

ActiveRecord::Schema.define(version: 20160523004356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "ltree"

  create_table "accounts", id: false, force: :cascade do |t|
    t.string   "plaid_acct_id"
    t.string   "account_name"
    t.string   "account_number"
    t.float    "available_balance"
    t.float    "current_balance"
    t.string   "institution_type"
    t.string   "name"
    t.string   "numbers"
    t.string   "acct_subtype"
    t.string   "acct_type"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "public_token_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.ltree    "path"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "default",    default: false
  end

  create_table "income_statements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plaid_categories", force: :cascade do |t|
    t.integer  "plaid_cat_id"
    t.integer  "category_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "public_tokens", force: :cascade do |t|
    t.string "token"
    t.string "user_id"
  end

  create_table "time_periods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", id: false, force: :cascade do |t|
    t.string   "plaid_trans_id"
    t.string   "account_id"
    t.float    "amount"
    t.string   "trans_name"
    t.integer  "plaid_cat_id"
    t.string   "plaid_cat_type"
    t.date     "date"
    t.string   "vendor_address"
    t.string   "vendor_city"
    t.string   "vendor_state"
    t.string   "vendor_zip"
    t.float    "vendor_lat"
    t.float    "vendor_lon"
    t.boolean  "pending"
    t.string   "pending_transaction"
    t.integer  "name_score"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end

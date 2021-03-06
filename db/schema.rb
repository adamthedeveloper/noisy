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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110814072325) do

  create_table "accounts", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email", :unique => true
  add_index "accounts", ["reset_password_token"], :name => "index_accounts_on_reset_password_token", :unique => true

  create_table "addresses", :force => true do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_addresses", :force => true do |t|
    t.integer  "billing_addressable_id"
    t.string   "billing_addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "subtotal",   :default => 0.0
  end

  create_table "checkout_transactions", :force => true do |t|
    t.string   "unique_token"
    t.integer  "cart_id"
    t.string   "status"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_transactions", ["cart_id"], :name => "index_checkout_transactions_on_cart_id"
  add_index "checkout_transactions", ["unique_token"], :name => "index_checkout_transactions_on_unique_token"

  create_table "orders", :force => true do |t|
    t.integer  "account_id"
    t.float    "total"
    t.string   "status",     :default => "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "subtotal",   :default => 0.0
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.integer  "credit_value"
    t.string   "kind",         :default => "Credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.string   "city"
    t.string   "state"
    t.string   "avatar"
    t.string   "occupation"
    t.string   "company"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "wepay_auth_code"
  end

  create_table "purchase_items", :force => true do |t|
    t.integer  "purchaseable_id"
    t.string   "purchaseable_type", :default => "Cart"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",          :default => 0
  end

  create_table "shipping_addresses", :force => true do |t|
    t.integer  "shipping_addressable_id"
    t.string   "shipping_addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sounds", :force => true do |t|
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

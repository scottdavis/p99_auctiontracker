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

ActiveRecord::Schema.define(:version => 20110202034509) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true

  create_table "admins", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "auctions", :force => true do |t|
    t.datetime "time"
    t.decimal  "price",      :precision => 10, :scale => 0
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hash_data"
    t.boolean  "hidden",                                    :default => false
    t.string   "player"
  end

  add_index "auctions", ["hash_data"], :name => "index_auctions_on_hash_data"
  add_index "auctions", ["item_id"], :name => "index_auctions_on_item_id"
  add_index "auctions", ["price"], :name => "index_auctions_on_price"
  add_index "auctions", ["time"], :name => "index_auctions_on_time"

  create_table "item_aliases", :force => true do |t|
    t.string   "alias"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_caches", :force => true do |t|
    t.string   "name"
    t.string   "alla_id"
    t.text     "meta"
    t.text     "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_caches", ["name"], :name => "index_item_caches_on_name"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",        :default => false
    t.integer  "item_cache_id"
    t.boolean  "flagged"
  end

  add_index "items", ["item_cache_id"], :name => "index_items_on_item_cache_id"
  add_index "items", ["name"], :name => "index_items_on_name"

  create_table "logs", :force => true do |t|
    t.string   "ip_address"
    t.string   "log"
    t.datetime "processed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

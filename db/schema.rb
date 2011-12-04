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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111204184640) do

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "active",         :default => true
    t.string   "ancestry"
    t.integer  "ancestry_depth", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["ancestry"], :name => "index_messages_on_ancestry"
  add_index "messages", ["ancestry_depth"], :name => "index_messages_on_ancestry_depth"
  add_index "messages", ["author_id"], :name => "index_messages_on_author_id"
  add_index "messages", ["recipient_id"], :name => "index_messages_on_recipient_id"

  create_table "messages_recipients", :id => false, :force => true do |t|
    t.integer "message_id",   :null => false
    t.integer "recipient_id", :null => false
  end

  add_index "messages_recipients", ["message_id", "recipient_id"], :name => "index_messages_recipients_on_message_id_and_recipient_id", :unique => true
  add_index "messages_recipients", ["message_id"], :name => "index_messages_recipients_on_message_id"
  add_index "messages_recipients", ["recipient_id"], :name => "index_messages_recipients_on_recipient_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "admin",                                 :default => false, :null => false
    t.string   "username",                              :default => "",    :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end

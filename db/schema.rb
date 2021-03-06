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

ActiveRecord::Schema.define(:version => 20121124093056) do

  create_table "acceptances", :force => true do |t|
    t.decimal  "money"
    t.string   "bank"
    t.date     "expire"
    t.string   "unit"
    t.string   "number"
    t.integer  "status"
    t.integer  "in_come_id"
    t.integer  "expenditure_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "announcements", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "announcements", ["user_id"], :name => "index_announcements_on_user_id"

  create_table "attaches", :force => true do |t|
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "attendances", :force => true do |t|
    t.text     "caption"
    t.string   "attach_ids"
    t.date     "for_month"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bank_accounts", :force => true do |t|
    t.string   "bankname"
    t.string   "accountname"
    t.decimal  "over",        :default => 0.0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "goods"
    t.string   "contact"
    t.string   "contact_person"
    t.string   "address"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "deliveries", :force => true do |t|
    t.text     "caption"
    t.string   "client"
    t.string   "goods"
    t.string   "attach_ids"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "expenditures", :force => true do |t|
    t.decimal  "money"
    t.string   "payto"
    t.integer  "mode"
    t.integer  "bank_account_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name",                             :null => false
    t.string   "org_group_access", :default => ""
    t.string   "org_user_access",  :default => ""
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "group_id", :null => false
  end

  create_table "in_comes", :force => true do |t|
    t.decimal  "money"
    t.string   "payer"
    t.integer  "mode"
    t.string   "from"
    t.date     "fromtime"
    t.integer  "bank_account_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "in_stores", :force => true do |t|
    t.text     "caption"
    t.string   "name"
    t.string   "attach_ids"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "topic"
    t.text     "body"
    t.integer  "received_messageable_id"
    t.string   "received_messageable_type"
    t.integer  "sent_messageable_id"
    t.string   "sent_messageable_type"
    t.boolean  "opened",                     :default => false
    t.boolean  "recipient_delete",           :default => false
    t.boolean  "sender_delete",              :default => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "ancestry"
    t.boolean  "recipient_permanent_delete", :default => false
    t.boolean  "sender_permanent_delete",    :default => false
  end

  add_index "messages", ["ancestry"], :name => "index_messages_on_ancestry"
  add_index "messages", ["sent_messageable_id", "received_messageable_id"], :name => "acts_as_messageable_ids"

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notes", ["user_id"], :name => "index_notes_on_user_id"

  create_table "out_stores", :force => true do |t|
    t.text     "caption"
    t.string   "name"
    t.string   "person"
    t.string   "attach_ids"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reimbursements", :force => true do |t|
    t.decimal  "money"
    t.text     "caption"
    t.string   "category"
    t.integer  "status",     :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "sales_contracts", :force => true do |t|
    t.decimal  "money"
    t.string   "name"
    t.string   "client"
    t.text     "caption"
    t.string   "attach_ids"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "supl_contracts", :force => true do |t|
    t.text     "caption"
    t.string   "name"
    t.decimal  "money"
    t.integer  "supplier_id"
    t.string   "attach_ids"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "supl_contracts", ["supplier_id"], :name => "index_supl_contracts_on_supplier_id"

  create_table "suppliers", :force => true do |t|
    t.string   "goods"
    t.string   "name"
    t.string   "contact"
    t.string   "contact_person"
    t.string   "address"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tasks", :force => true do |t|
    t.text     "caption"
    t.string   "attach_ids"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transfers", :force => true do |t|
    t.decimal  "money"
    t.text     "caption"
    t.string   "attach_ids"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "unpaid_debts", :force => true do |t|
    t.decimal  "money"
    t.text     "caption"
    t.string   "number"
    t.integer  "status",     :default => 0
    t.integer  "group_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "name"
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end

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

ActiveRecord::Schema.define(:version => 20111214013406) do

  create_table "deal_codes", :force => true do |t|
    t.string   "code"
    t.integer  "transaction_id"
    t.integer  "deal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deal_templates", :force => true do |t|
    t.string   "text_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "html_description"
  end

  create_table "deals", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "deal_template_id"
    t.integer  "discounted_price"
    t.integer  "original_price"
    t.datetime "start_on"
    t.datetime "end_on"
    t.boolean  "active"
    t.text     "fineprint"
    t.string   "product"
    t.string   "img"
    t.integer  "quantity"
    t.datetime "delivery_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurant_users", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "date_joined"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sms"
    t.boolean  "email"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "smsNum"
    t.string   "subdomain"
    t.integer  "user_id"
    t.string   "twitter_handle"
    t.string   "twitter_token"
    t.string   "twitter_secret"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.integer  "braintree_id"
  end

  create_table "users", :force => true do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_confirmed",         :default => false
    t.boolean  "phone_confirmed",         :default => false
    t.string   "email_confirmation_code"
    t.string   "sms_confirmation_code"
    t.string   "stripe_id"
  end

end

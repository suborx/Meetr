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

ActiveRecord::Schema.define(:version => 20101111130256) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.text     "bio"
    t.integer  "num_of_votes",         :default => 0
    t.integer  "num_of_presentations", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "meetup_users", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.integer  "meetup_id",                      :null => false
    t.boolean  "is_attending", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetup_users", ["is_attending"], :name => "index_meetup_users_on_is_attending"
  add_index "meetup_users", ["meetup_id"], :name => "index_meetup_users_on_meetup_id"
  add_index "meetup_users", ["user_id"], :name => "index_meetup_users_on_user_id"

  create_table "meetups", :force => true do |t|
    t.string   "name",                            :null => false
    t.text     "description"
    t.datetime "happening_at",                    :null => false
    t.string   "location"
    t.string   "geo_latitude"
    t.string   "geo_longitude"
    t.integer  "user_id",                         :null => false
    t.boolean  "is_active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetups", ["is_active"], :name => "index_meetups_on_is_active"
  add_index "meetups", ["user_id"], :name => "index_meetups_on_user_id"

  create_table "presentations", :force => true do |t|
    t.string   "name",                                :null => false
    t.text     "description"
    t.integer  "duration",          :default => 1800
    t.integer  "user_id",                             :null => false
    t.integer  "meetup_id",                           :null => false
    t.boolean  "is_active",         :default => true
    t.boolean  "is_open_for_votes", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "presentations", ["is_active"], :name => "index_presentations_on_is_active"
  add_index "presentations", ["is_open_for_votes"], :name => "index_presentations_on_is_open_for_votes"
  add_index "presentations", ["meetup_id"], :name => "index_presentations_on_meetup_id"
  add_index "presentations", ["user_id"], :name => "index_presentations_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "timelines", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "meetup_id",  :null => false
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timelines", ["meetup_id"], :name => "index_timelines_on_meetup_id"
  add_index "timelines", ["user_id"], :name => "index_timelines_on_user_id"

  create_table "user_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.integer  "presentation_id",                    :null => false
    t.boolean  "is_deleted",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["presentation_id"], :name => "index_votes_on_presentation_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end

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

ActiveRecord::Schema.define(:version => 20110205085407) do

  create_table "a_comments", :force => true do |t|
    t.integer  "answer_id",  :null => false
    t.text     "content",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "user_id",    :null => false
    t.string   "activity",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.text     "content",     :null => false
    t.integer  "user_id",     :null => false
    t.integer  "question_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
  end

  create_table "apps", :force => true do |t|
    t.string   "university",                :null => false
    t.string   "department",                :null => false
    t.integer  "degree",     :limit => 255, :null => false
    t.date     "deadline"
    t.integer  "status",                    :null => false
    t.integer  "user_id",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beta_invites", :force => true do |t|
    t.string   "email",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_people", :force => true do |t|
    t.string   "contact_name",  :null => false
    t.string   "contact_email"
    t.integer  "contact_phone"
    t.integer  "app_id",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_us", :force => true do |t|
    t.string   "content"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "delayed_jobs_locked_by"
  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feedbacks", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "l_comments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "link_id",    :null => false
    t.text     "content",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "title",                       :null => false
    t.string   "URL",                         :null => false
    t.integer  "user_id",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flags",        :default => 1, :null => false
    t.integer  "rating",       :default => 0
    t.datetime "flagged_time"
  end

  create_table "questions", :force => true do |t|
    t.text     "content",                     :null => false
    t.string   "title",                       :null => false
    t.integer  "user_id",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flags",        :default => 1
    t.integer  "rating",       :default => 0
    t.datetime "flagged_time"
  end

  create_table "topic_questions", :force => true do |t|
    t.integer  "topic_id",    :null => false
    t.integer  "question_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topic_users", :force => true do |t|
    t.integer  "topic_id",   :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "updates", :force => true do |t|
    t.integer  "app_id",     :null => false
    t.string   "content",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_answers", :force => true do |t|
    t.integer  "answer_id",  :null => false
    t.integer  "user_id",    :null => false
    t.integer  "rating",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_links", :force => true do |t|
    t.integer  "link_id",                     :null => false
    t.integer  "user_id",                     :null => false
    t.integer  "flagged",      :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
    t.datetime "flagged_time"
  end

  create_table "user_questions", :force => true do |t|
    t.integer  "question_id",                     :null => false
    t.integer  "user_id",                         :null => false
    t.integer  "flagged",      :default => 1,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
    t.datetime "flagged_time"
    t.boolean  "follow",       :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => ""
    t.string   "password_salt",                       :default => ""
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
    t.string   "name"
    t.integer  "user_type",                           :default => 2
    t.string   "invitation_token",     :limit => 20
    t.datetime "invitation_sent_at"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

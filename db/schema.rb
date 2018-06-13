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

ActiveRecord::Schema.define(:version => 20130916114101) do

  create_table "aggregator_configurations", :force => true do |t|
    t.string "source"
    t.text   "feed_object"
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "gist"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "rss_link"
    t.integer  "user_id"
    t.integer  "meetup_id"
  end

  add_index "articles", ["slug"], :name => "index_articles_on_slug", :unique => true

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "parent_id"
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
    t.string   "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "drafts", :force => true do |t|
    t.string   "object_type",  :null => false
    t.integer  "object_id",    :null => false
    t.string   "draft_object"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drafts", ["object_type", "object_id"], :name => "index_drafts_on_object_type_and_object_id"

  create_table "experiences", :force => true do |t|
    t.string "level"
  end

  create_table "meetups", :force => true do |t|
    t.string   "topic"
    t.text     "description"
    t.string   "place"
    t.datetime "date_and_time"
    t.boolean  "cancelled",             :default => false
    t.string   "letter_subject"
    t.text     "letter_body"
    t.string   "url"
    t.boolean  "premoderation",         :default => false
    t.string   "decline_email_subject"
    t.text     "decline_email_body"
    t.string   "accept_email_subject"
    t.text     "accept_email_body"
    t.datetime "finish_date_and_time"
    t.boolean  "status",                :default => true
  end

  create_table "participants", :force => true do |t|
    t.integer  "meetup_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accepted",   :limit => 1, :default => 2
  end

  add_index "participants", ["meetup_id"], :name => "index_participants_on_meetup_id"
  add_index "participants", ["user_id"], :name => "index_participants_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "experience_id"
    t.boolean  "subscribed",              :default => false
    t.boolean  "subscribed_for_comments", :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "locale",                  :default => "ru"
  end

  create_table "questions", :force => true do |t|
    t.string   "gist"
    t.integer  "meetup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind_of_response"
    t.boolean  "required",         :default => true
    t.integer  "min_length"
    t.integer  "length"
    t.integer  "max_length"
  end

  create_table "quizzes", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "question_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_blocks", :force => true do |t|
    t.string "title"
    t.string "subject"
    t.string "search"
    t.string "footer_text"
    t.text   "widget",      :null => false
  end

  create_table "user_tokens", :force => true do |t|
    t.integer "user_id"
    t.string  "provider"
    t.string  "uid"
  end

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                              :default => false
    t.boolean  "banned"
    t.string   "password_salt"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "content"
    t.string   "title"
    t.datetime "published_at"
    t.text     "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end

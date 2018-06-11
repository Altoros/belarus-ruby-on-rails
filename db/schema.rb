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

ActiveRecord::Schema.define(version: 20130916114101) do

  create_table "aggregator_configurations", force: :cascade do |t|
    t.string "source",      limit: 255
    t.text   "feed_object", limit: 65535
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.string   "gist",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
    t.string   "rss_link",   limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "meetup_id",  limit: 4
  end

  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
    t.integer  "parent_id",  limit: 4
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0
    t.integer  "attempts",   limit: 4,     default: 0
    t.text     "handler",    limit: 65535
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue",      limit: 255
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "drafts", force: :cascade do |t|
    t.string   "object_type",  limit: 255, null: false
    t.integer  "object_id",    limit: 4,   null: false
    t.string   "draft_object", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drafts", ["object_type", "object_id"], name: "index_drafts_on_object_type_and_object_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.string "level", limit: 255
  end

  create_table "meetups", force: :cascade do |t|
    t.string   "topic",                 limit: 255
    t.text     "description",           limit: 65535
    t.string   "place",                 limit: 255
    t.datetime "date_and_time"
    t.boolean  "cancelled",                           default: false
    t.string   "letter_subject",        limit: 255
    t.text     "letter_body",           limit: 65535
    t.string   "url",                   limit: 255
    t.boolean  "premoderation",                       default: false
    t.string   "decline_email_subject", limit: 255
    t.text     "decline_email_body",    limit: 65535
    t.string   "accept_email_subject",  limit: 255
    t.text     "accept_email_body",     limit: 65535
    t.datetime "finish_date_and_time"
    t.boolean  "status",                              default: true
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "meetup_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accepted",   limit: 1, default: 2
  end

  add_index "participants", ["meetup_id"], name: "index_participants_on_meetup_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.integer  "experience_id",           limit: 4
    t.boolean  "subscribed",                          default: false
    t.boolean  "subscribed_for_comments",             default: false
    t.string   "avatar_file_name",        limit: 255
    t.string   "avatar_content_type",     limit: 255
    t.integer  "avatar_file_size",        limit: 4
    t.datetime "avatar_updated_at"
    t.string   "locale",                  limit: 255, default: "ru"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "gist",             limit: 255
    t.integer  "meetup_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind_of_response", limit: 4
    t.boolean  "required",                     default: true
    t.integer  "min_length",       limit: 4
    t.integer  "length",           limit: 4
    t.integer  "max_length",       limit: 4
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "participant_id", limit: 4
    t.integer  "question_id",    limit: 4
    t.text     "answer",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_pages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "permalink",  limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_blocks", force: :cascade do |t|
    t.string "title",       limit: 255
    t.string "subject",     limit: 255
    t.string "search",      limit: 255
    t.string "footer_text", limit: 255
    t.string "widget",      limit: 255, default: "", null: false
  end

  create_table "user_tokens", force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.string  "provider", limit: 255
    t.string  "uid",      limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "is_admin",                           default: false
    t.boolean  "banned"
    t.string   "password_salt",          limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "content",      limit: 255
    t.string   "title",        limit: 255
    t.datetime "published_at"
    t.text     "description",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

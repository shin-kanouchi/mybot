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

ActiveRecord::Schema.define(version: 20161025122111) do

  create_table "bots", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "bot_name",     limit: 255
    t.integer  "gender",       limit: 4
    t.integer  "bot_rank",     limit: 4,   default: 0
    t.integer  "battle_point", limit: 4,   default: 3
    t.integer  "hair_color",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluates", force: :cascade do |t|
    t.integer  "evaluator",  limit: 4
    t.integer  "user_x_id",  limit: 4
    t.integer  "user_y_id",  limit: 4
    t.integer  "topic_id",   limit: 4
    t.integer  "win_flag",   limit: 4, default: 3
    t.integer  "state_flag", limit: 4, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pairwises", force: :cascade do |t|
    t.integer  "evaluate_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "tweet_id",        limit: 4
    t.integer  "reply_x_id",      limit: 4
    t.integer  "reply_y_id",      limit: 4
    t.integer  "inequality_flag", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sentences", force: :cascade do |t|
    t.integer  "source_flag", limit: 4
    t.integer  "topic_id",    limit: 4
    t.text     "sentence",    limit: 65535
    t.integer  "bad_q_count", limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "topic_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trains", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "tweet_id",       limit: 4
    t.integer  "reply_id",       limit: 4
    t.integer  "topic_id",       limit: 4
    t.integer  "adequacy_flag",  limit: 4, default: 10
    t.integer  "choice_count",   limit: 4, default: 0
    t.integer  "free_b2u_count", limit: 4, default: 0
    t.integer  "free_u2b_count", limit: 4, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "nickname",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

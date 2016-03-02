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

ActiveRecord::Schema.define(version: 20160302065334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "github_repo_data", force: :cascade do |t|
    t.integer  "github_repo_id"
    t.json     "languages"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "github_repos", force: :cascade do |t|
    t.integer  "repo_id"
    t.string   "repo_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "github_user_data", force: :cascade do |t|
    t.integer  "github_user_id"
    t.string   "name"
    t.string   "location"
    t.string   "email"
    t.boolean  "hireable"
    t.string   "company"
    t.string   "bio"
    t.integer  "followers"
    t.integer  "public_repos"
    t.json     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "github_users", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "github_repo_id"
    t.boolean  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

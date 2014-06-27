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

ActiveRecord::Schema.define(version: 20140627172253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "about"
    t.text     "rules"
    t.string   "first_prize_info"
    t.string   "second_prize_info"
    t.string   "third_prize_info"
    t.string   "category"
    t.datetime "audition_start_datetime"
    t.datetime "audition_end_datetime"
    t.string   "cover_pic_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "role"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "dob"
    t.integer  "age"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "password"
    t.string   "likes"
    t.string   "dislikes"
    t.string   "ambition"
    t.string   "talent"
    t.string   "aboutme"
    t.string   "gender"
    t.string   "gplus"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

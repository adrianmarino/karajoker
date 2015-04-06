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

ActiveRecord::Schema.define(version: 20150406021507) do

  create_table "karaokes", force: true do |t|
    t.string   "title"
    t.string   "youtube_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author"
    t.integer  "year"
  end

  add_index "karaokes", ["title", "author"], name: "karaoke_title_author", type: :fulltext
  add_index "karaokes", ["youtube_id"], name: "index_karaokes_on_youtube_id", unique: true, using: :btree

  create_table "karaokes_tags", id: false, force: true do |t|
    t.integer "karaoke_id"
    t.integer "tag_id"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end

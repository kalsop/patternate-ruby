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

ActiveRecord::Schema.define(version: 20140906111819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pattern_collection", force: true do |t|
    t.string  "name",               limit: 128, default: "", null: false
    t.string  "slug",               limit: 128
    t.integer "pattern_company_id",             default: 0
  end

  add_index "pattern_collection", ["pattern_company_id"], name: "pattern_collection_pattern_company_id", using: :btree

  create_table "pattern_company", force: true do |t|
    t.string "name", limit: 128
    t.string "slug", limit: 128
  end

  create_table "patterns", force: true do |t|
    t.integer "pattern_company_id",                 default: 0
    t.string  "pattern_number",        limit: 128
    t.integer "pattern_collection_id"
    t.string  "url",                   limit: 500
    t.string  "main_image",            limit: 500
    t.string  "line_drawing",          limit: 500
    t.string  "description",           limit: 2000
    t.string  "pattern_name"
    t.integer "garment_type_id"
  end

  add_index "patterns", ["pattern_collection_id"], name: "patterns_pattern_collection_id", using: :btree
  add_index "patterns", ["pattern_company_id"], name: "patterns_pattern_company_id", using: :btree

  create_table "patterns_styles", id: false, force: true do |t|
    t.integer "pattern_id"
    t.integer "style_id"
  end

  add_index "patterns_styles", ["pattern_id", "style_id"], name: "index_patterns_styles_on_pattern_id_and_style_id", using: :btree

  create_table "styles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

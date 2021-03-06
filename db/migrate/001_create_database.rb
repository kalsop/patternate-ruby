class CreateDatabase < ActiveRecord::Migration
  
  def self.up

  create_table "garment_type", force: true do |t|
    t.string "name",      limit: 128
    t.string "slug",      limit: 128
    t.string "parent-id", limit: 128
  end

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

  create_table "pattern_for", force: true do |t|
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
  end

  add_index "patterns", ["pattern_collection_id"], name: "patterns_pattern_collection_id", using: :btree
  add_index "patterns", ["pattern_company_id"], name: "patterns_pattern_company_id", using: :btree

  create_table "patterns_garment_type", id: false, force: true do |t|
    t.integer "pattern_id"
    t.integer "garment_type_id", default: 0
  end

  add_index "patterns_garment_type", ["garment_type_id"], name: "patterns_garment_type_patterns_garment_type_id", using: :btree
  add_index "patterns_garment_type", ["pattern_id"], name: "patterns_garment_type_pattern_id", using: :btree

  create_table "patterns_pattern_for", id: false, force: true do |t|
    t.integer "pattern_id"
    t.integer "pattern_for_id"
  end

  add_index "patterns_pattern_for", ["pattern_for_id"], name: "patterns_pattern_for_pattern_for_id", using: :btree
  add_index "patterns_pattern_for", ["pattern_id"], name: "patterns_pattern_for_pattern_id", using: :btree

end

end

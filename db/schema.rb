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

ActiveRecord::Schema.define(version: 20161122183237) do

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "slot"
    t.string   "tier"
    t.string   "craft_type"
    t.integer  "armor"
    t.integer  "damage_min"
    t.integer  "damage_max"
    t.integer  "val"
    t.integer  "enhancement_slots"
    t.string   "other_effects"
    t.string   "comments"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "armor_type"
    t.float    "weight"
    t.integer  "level_requirement"
    t.string   "thumbnail_url"
    t.string   "wiki_url"
    t.string   "thumbnail_size"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end

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

ActiveRecord::Schema.define(version: 20180908093145) do

  create_table "breeds", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_breeds_on_name", unique: true
  end

  create_table "cats", force: :cascade do |t|
    t.integer "breed_id"
    t.integer "location_id"
    t.integer "cost", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "checksum"
    t.index ["breed_id"], name: "index_cats_on_breed_id"
    t.index ["checksum"], name: "index_cats_on_checksum", unique: true
    t.index ["location_id"], name: "index_cats_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

end

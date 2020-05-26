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

ActiveRecord::Schema.define(version: 2020_05_25_123446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breeds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "uuid"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.string "img_url"
    t.integer "store_id"
    t.integer "city_id"
    t.integer "breed_id"
    t.boolean "archived"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "uuid"
    t.text "raw_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "uuid"
    t.string "currency"
    t.string "api_endpoint", null: false
    t.string "name", null: false
    t.string "response_type", null: false
    t.text "mapping", null: false, array: true
    t.boolean "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

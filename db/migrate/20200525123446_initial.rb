class Initial < ActiveRecord::Migration[5.2]
  def change
    create_table "items", force: :cascade do |t|
      t.string "uuid"
      t.monetize "price"
      t.string "img_url"
      t.integer "store_id"
      t.integer "city_id"
      t.integer "breed_id"
      t.boolean "archived"

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "cities", force: :cascade do |t|
      # in real life there should be an array of names like ['NY', 'NYC', 'New York']
      # orm third party tooling for that
      t.string 'name', null: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "breeds", force: :cascade do |t|
      t.string 'name', null: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "stores", force: :cascade do |t|
      t.string "uuid"
      t.string "currency"
      t.string "api_endpoint", null: false
      t.string "name", null: false
      t.string "response_type", null: false
      t.text "mapping", array: true, null: false
      t.boolean "active", null: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "requests", force: :cascade do |t|
      t.string "uuid"
      t.text "raw_data"

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end

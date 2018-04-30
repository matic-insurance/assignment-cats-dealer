class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.string :breed, index: true
      t.string :location, index: true
      t.text :picture_url
      t.decimal :price, index: true

      t.timestamps
    end
  end
end

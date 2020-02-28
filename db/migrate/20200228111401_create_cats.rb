class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.string  :breed
      t.string  :location
      t.integer :price
      t.string  :image_url

      t.timestamps
    end
  end
end

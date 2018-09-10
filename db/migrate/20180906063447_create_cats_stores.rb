class CreateCatsStores < ActiveRecord::Migration[5.1]
  def change
    create_table :cats_stores do |t|
      t.text :image
      t.string :location
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end

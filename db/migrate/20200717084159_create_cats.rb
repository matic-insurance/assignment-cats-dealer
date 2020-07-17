class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.string :breed
      t.integer :price
      t.string :location
      t.string :image_src
    end
  end
end

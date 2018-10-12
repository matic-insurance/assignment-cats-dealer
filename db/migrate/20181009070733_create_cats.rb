class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.string :name
      t.float :price
      t.string :location
      t.string :image

      t.timestamps
    end
  end
end

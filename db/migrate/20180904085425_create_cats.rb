class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.references :breed, foreign_key: true
      t.references :location, foreign_key: true
      t.integer :cost, null: false
      t.string :image

      t.timestamps
    end
  end
end

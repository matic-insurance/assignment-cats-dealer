class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :url
      t.string :format
      t.boolean :active
      t.string :product
      t.timestamps
    end
  end
end

class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :street
      t.string :city
      t.string :district
      t.string :country
      t.string :postal_code
    end
  end
end

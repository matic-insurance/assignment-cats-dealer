class CreateBreeds < ActiveRecord::Migration[5.1]
  def change
    create_table :breeds do |t|
      t.string :name, null: false
    end

    add_index :breeds, :name, unique: true
  end
end

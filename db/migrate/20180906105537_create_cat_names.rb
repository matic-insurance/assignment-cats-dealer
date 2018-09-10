class CreateCatNames < ActiveRecord::Migration[5.1]
  def change
    create_table :cat_names do |t|
      t.string :name

      t.timestamps
    end
  end
end

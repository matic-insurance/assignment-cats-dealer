class AddIndexToProviders < ActiveRecord::Migration[5.1]
  def change
    add_index :providers, :name, unique: true
  end
end

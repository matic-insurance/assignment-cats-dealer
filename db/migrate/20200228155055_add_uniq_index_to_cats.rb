class AddUniqIndexToCats < ActiveRecord::Migration[5.1]
  def change
    add_index :cats, %i[breed location price image_url], unique: true, name: :index_uniq_cats
  end
end

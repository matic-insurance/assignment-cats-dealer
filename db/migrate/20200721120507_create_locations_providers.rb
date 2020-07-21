class CreateLocationsProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :locations_providers, id: false do |t|
      t.belongs_to :provider, index: true
      t.belongs_to :location, index: true
    end
  end
end

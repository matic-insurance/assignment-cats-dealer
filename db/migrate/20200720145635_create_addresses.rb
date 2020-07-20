class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.belongs_to :providers
      t.belongs_to :locations
    end
  end
end

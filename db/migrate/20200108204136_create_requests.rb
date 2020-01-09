class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.json :request_params
      t.string :product
      t.timestamps
    end
  end
end

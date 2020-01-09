class AddShowPositionToCats < ActiveRecord::Migration[5.1]
  def change
    add_column :cats, :show_position, :integer
  end
end

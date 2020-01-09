class AddRequestIdToCats < ActiveRecord::Migration[5.1]
  def change
    add_reference :cats, :request, index: true
  end
end

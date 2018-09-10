class AddChecksumToCat < ActiveRecord::Migration[5.1]
  def change
    add_column :cats, :checksum, :string
    add_index :cats, :checksum, unique: true
  end
end

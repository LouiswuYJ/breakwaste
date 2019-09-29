class AddSlugToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :slug, :string
    add_index :orders, :slug, unique: true
  end
end

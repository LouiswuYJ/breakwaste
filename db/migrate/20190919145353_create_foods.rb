class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :title
      t.text :address
      t.string :phone
      t.integer :quantity
      t.integer :origin_price
      t.integer :discount_price
      t.string :pickup_time
      t.string :picture
      t.text :description

      t.timestamps
    end
  end
end

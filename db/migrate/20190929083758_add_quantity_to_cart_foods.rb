class AddQuantityToCartFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_foods, :quantity, :integer, default: 1
  end
end

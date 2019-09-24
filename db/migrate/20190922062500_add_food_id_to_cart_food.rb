class AddFoodIdToCartFood < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_foods, :food, foreign_key: true
  end
end

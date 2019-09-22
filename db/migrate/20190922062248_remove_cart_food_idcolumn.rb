class RemoveCartFoodIdcolumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_foods, :food_id
  end
end

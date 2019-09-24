class RenameCartFoodUserIdcolumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :cart_foods, :user_id, :food_id
  end
end

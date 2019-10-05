class AddGiverToCartFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_foods, :giver_id, :integer
  end
end

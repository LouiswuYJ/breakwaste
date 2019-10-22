module CartsHelper
  def find_food_giver(food)
    User.find(food)
  end

  def find_rescuer_cart_foods(giver_info)
    @cart_foods.where(giver_id: giver_info)
  end
end

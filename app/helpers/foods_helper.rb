module FoodsHelper
  # def current_user
  #   User.find_by(id: )
  # end
  def find_food_user(food)
    User.find(food.user_id)
  end
end

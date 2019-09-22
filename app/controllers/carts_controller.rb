class CartsController < ApplicationController
  def show
    current_cart = Cart.find_by(user_id: current_user.id)
    @foods = current_cart.foods
  end
end
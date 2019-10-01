class CartsController < ApplicationController
  before_action :find_cart_food, only: [:destroy]
  def show
    # current_cart = Cart.find_by(user_id: current_user.id)    寫在application
    @foods = current_cart.foods
    # @cart_food = CartFood.find_by(food_id: params[:id])
    @cart_foods = CartFood.all
  end

  def destroy
    current_cart_foods.where(food_id: @food.id).destroy_all   
    redirect_to cart_path, notice: '已刪除該筆資料'
  end

  def destroy_cart
    if current_cart_foods
      current_user.cart.cart_foods.destroy_all
      redirect_to foods_path, notice: '購物車已清空！！'
    else
      redirect_to foods_path, notice: '購物車已經是空的了喔！！' 
    end   
  end

  private
  def current_cart_foods
    current_user.cart_foods
  end

  def find_cart_food
    @food = current_cart.foods.find_by(id: params[:format])    
  end
end
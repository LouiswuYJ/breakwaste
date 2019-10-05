class CartsController < ApplicationController
  before_action :find_cart_food, only: [:destroy, :show]

  def show
    @givers = User.joins(:cart_food_givens).where('cart_foods.cart_id = ?', current_cart.id).distinct
    # @cart_foods = current_cart.cart_foods.where(giver_id: @givers.ids)
    # Food.join(:cart_foods).where(cart_foods: {id: params[:food_id]})
    # @cart_foods = CartFood.includes(:food).where(food_id: params[:food_id]).order(:giver_id)
  end

  def destroy
    CartFood.where(id: params[:format]).destroy_all  
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

  def checkout
    @order = current_user.rescuer_orders.build(giver_id: params[:giver_id])
    @cart_foods = current_cart.cart_foods.where(giver_id: params[:giver_id]).order(:giver_id)
  end

  private
  def current_cart_foods
    current_user.cart_foods
  end

  def find_cart_food
    @food = current_cart.foods.find_by(id: params[:format])    
  end
end
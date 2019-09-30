class CartFoodsController < ApplicationController
  before_action :find_cart_food, only: [:update]

  def create
    @cart_food = CartFood.new(cart_food_params)
    @cart_food.cart = current_cart
    @cart_food.food = Food.find_by(id: params[:format])
    if @cart_food.save
      redirect_to foods_path, notice: '已加入購物車！！'
    else
      redirect_to foods_path, notice: '加入失敗'
    end
  end
  
  def update
    # render html:params[:format]
    @cart_food = CartFood.find_or_initialize_by(cart_id: current_cart.id)
    if @cart_food.food_id == params[:fomrat] 
      @cart_food.update(cart_food_params)
      redirect_to foods_path, notice: '已更改此商品數量！！'
    else 
      @cart_food = CartFood.new(cart_food_params)
      @cart_food.cart = current_cart
      @cart_food.food = Food.find_by(id: params[:format])
      if @cart_food.save
        redirect_to foods_path, notice: '已加入購物車！！'
      else
        redirect_to foods_path, notice: '加入失敗'
      end
    end
    # @cart_food = CartFood.find_or_initialize_by(cart_id: current_cart.id)
    # @cart_food.cart = current_cart
    # @cart_food.food = Food.find_by(id: params[:format])
    # if @cart_food.update(cart_food_params)
    #   redirect_to foods_path, notice: '已加入購物車！！'
    # else
    #   redirect_to foods_path, notice: '加入失敗'
    # end
  end

  private
  def find_cart_food
    @cart_food = CartFood.find_by(cart_id: current_cart.id)
  end

  def cart_food_params
    params.require(:cart_food).permit(:quantity)
  end
end
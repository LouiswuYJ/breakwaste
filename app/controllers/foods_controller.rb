class FoodsController < ApplicationController
  # require 'net/http'
  before_action :find_food, only: [:edit, :update, :destroy]
  def search
  end

  def index
    @foods = Food.order(created_at: :desc)  
  end

  def show
    @food = Food.find_by(id: params[:id])
    current_cart_food
  end

  def new
    if user_signed_in?
      @food = Food.new
    else
      redirect_to user_session_path   
    end
  end

  def create   
    @food = current_user.foods.build(clean_params)
    if @food.save
      redirect_to foods_path, notice: '新增po文成功'
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @food.update(clean_params)
      redirect_to foods_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @food.destroy
      redirect_to foods_path, notice: "刪除成功"
    end
  end

  # def add_to_cart
  #   @add_food = CartFood.find_or_create_by(id: params[:id])
  #   if user_signed_in?
  #     current_cart.cart_foods << [@add_food]   #current_cart寫在appication_controller.rb
  #     redirect_to foods_path, notice: '已加入購物車！'  
  #   else
  #     redirect_to new_user_session_path
  #   end
  # end

  private
  def clean_params
    params.require(:food).permit(:title, :address, :phone, :quantity, :origin_price, :discount_price, :pickup_time, :picture, :description, :endup_time, :avatar)
  end

  def find_food
    @food = current_user.foods.find_by(id: params[:id])
  end
end

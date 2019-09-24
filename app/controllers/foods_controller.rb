class FoodsController < ApplicationController
  before_action :find_food, only: [:edit, :update, :destroy]
  def search
  end

  def index
    @foods = Food.all
  end

  def show
    @food = Food.find_by(id: params[:id])
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
      render :new
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

  def add_to_cart
    @add_food = Food.find(params[:id])
    if user_signed_in?
      current_cart.foods << [@add_food]   #current_cart寫在appication_controller.rb
      redirect_to foods_path, notice: '已加入購物車！'
    else
      redirect_to new_user_session_path
    end
  end

  private
  def clean_params
    params.require(:food).permit(:title, :address, :phone, :quantity, :origin_price, :discount_price, :pickup_time, :picture, :description)
  end

  def find_food
    @food = current_user.foods.find_by(id: params[:id])
  end
end

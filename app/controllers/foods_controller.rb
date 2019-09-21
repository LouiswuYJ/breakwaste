class FoodsController < ApplicationController
  before_action :find_food, only: [:show, :edit, :update, :destroy]
  def search
    
  end

  def index
    @foods = Food.all
  end

  def show
  end

  def new
    @food = Food.new
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
    else
      
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


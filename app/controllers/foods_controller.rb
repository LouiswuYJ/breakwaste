class FoodsController < ApplicationController
  # require 'net/http'
  before_action :find_food, only: [:edit, :update, :destroy]

  def index
    @foods = Food.search(params[:search]).order(created_at: :desc).page(params[:page]).per(6)
    return @foods if @foods.count >= 1
    redirect_to foods_path, notice: '無搜尋到符合條件的食物，但您應該會喜歡這些！'
  end

  def show
    if user_signed_in?
      @food = Food.find_by(id: params[:id])
      current_cart_food
    else 
      redirect_to user_session_path, notice: '請先登入會員！'  
    end
  end

  def new
    if current_user.name.nil?
      redirect_to edit_user_registration_path, notice: '新增貼文前請先填寫個人資料！'
    else
      old_food_params = Food.find_by(id: params[:food_id]) &.as_json || {}  
      if user_signed_in?
        @food = Food.new(old_food_params)
        if @food.avatar.attached?
          avatar_id = @food.avatar.id
          @food.avatar = ActiveStorage::Blob.find(avatar_id)
        end
      else
        redirect_to user_session_path   
      end  
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

  def history
    @foods = Food.where(user_id: current_user.id, quantity: 0).page(params[:page]).per(6)
  end

  def store
    if user_signed_in?
      @foods = current_user.foods
      @giver_store = Food.where(user_id: params[:id])
    else
      redirect_to user_session_path, notice: '請先登入會員！'  
    end
  end

  private
  def clean_params
    params.require(:food).permit(:title, :address, :phone, :quantity, :origin_price, :discount_price, :pickup_time, :picture, :description, :endup_time, :avatar)
  end

  def find_food
    @food = current_user.foods.find_by(id: params[:id])
  end
end

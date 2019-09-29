class CartFoodsController < ApplicationController
  before_action :find_cart_food, only: [:update]
  def index
    @cart_foods = CartFood.all
  end

  def create
    # render html: params[:format]
    # @cart_food.food = Food.find_by(id: params[:format])
    # @cart_food.cart = current_cart
    # CartFood.all

    @cart_food = CartFood.new(cart_food_params)
    @cart_food.cart = current_cart
    @cart_food.food = Food.find_by(id: params[:format])
    if @cart_food.save
      redirect_to foods_path, notice: '已加入購物車！！'
    else
      redirect_to foods_path, notice: '加入失敗'
    end
    # {"utf8"=>"✓", "authenticity_token"=>"TPZ94UZsCbLFlTLfPWYfWMtQF3QF/YYaKlmPHcTYk2Q86xMwgMjuFPpzEH/6OScGojRRq0fej6T2+Gi5t+Klrw==", "cart_food"=>{"quantity"=>"1"}, "commit"=>"新增Cart food", "controller"=>"cart_foods", "action"=>"create"}

    # {"utf8"=>"✓", "authenticity_token"=>"INn+E8M96ROxNbOlS9nTV1Wehk4ODsG5CzxSrHZWz+ZQxJDCBZkOtY7TkQWMhusJPPrAkUwtyAfXnbUIBWz5LQ==", "cart_food"=>{"quantity"=>"1"}, "commit"=>"新增Cart food", "controller"=>"cart_foods", "action"=>"create", "format"=>"2"}
  end
  
  def update
    # food = Food.find_by(id: params[:format])
    # @cart = Cart.find_or_create_by(id: current_user.id)
    # @cart_food.update_attribute(:quantity, params[:cart_food][:quantity])
    # redirect_to foods_path, notice: '已加入購物車！'
    # render html: params

    #       instrument = Instrument.find(1)
    #   @cart = Cart.find_or_create_by(id: current_user.id)
    # # @line_item = @cart.add_instrument(instrument)
    # @line_item.update_attribute(:quantity, params[:line_item][:quantity])
  end

  private
  def find_cart_food
    @cart_food = CartFood.find_by(cart_id: current_cart.id)
  end

  def cart_food_params
    params.require(:cart_food).permit(:quantity)
  end
end
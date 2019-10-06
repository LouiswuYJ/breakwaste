class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:show, :transaction, :destroy, :payment]
  
  def index
    # @orders = Order.where(user: current_cart)
    #或從使用者角度建立
    # if Order.find_by(user_id: current_user.id).nil?
    #   redirect_to foods_path, notice: '訂單現在是空的喔～'
    # else
    #   if current_user.id == Order.find_by(user_id: current_user.id).user_id
    #       @orders = current_user.rescuer_orders.order(created_at: :asc)
    #   end
    # end
    @rescuer_orders = current_user.rescuer_orders.order(created_at: :asc)
  end

  def giver
    @giver_orders = current_user.giver_orders.order(created_at: :asc)    
  end

  def payment
    @token = braintree_gateway.client_token.generate
  end

  def braintree_gateway
    Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => Figaro.env.BRAINTREE_MERCHANT_ID,
      :public_key => Figaro.env.BRAINTREE_PUBLIC_KEY,
      :private_key => Figaro.env.BRAINTREE_PRIVATE_KEY,
    )
  end

  def giver_order
    @giver_orders = current_user.giver_orders.friendly.find(params[:id]) 
  end
  
  def create
    giver_id = current_cart.cart_foods.find(params[:order][:cart_food_id]).giver_id
    @cart_foods = current_cart.cart_foods.where(giver_id: giver_id)
    @order = current_user.rescuer_orders.new(order_params)
    @order.giver_id = giver_id
    @cart_foods.each do |food|
      @order.order_items << OrderItem.new(food_id: food.food_id, quantity: food.quantity, giver_id: food.giver_id, rescuer_id: current_user.id)
    end
    #把購物車裡的東西拿出來，一條一條塞入order_items 
    if @order.save
      # current_cart.foods.destroy_all #訂單成立後購物車要清空  => 改成付款成立訂單後再刪除，暫時先關掉 
      redirect_to payment_order_path(@order), notice: '訂單已成立' 

    else
      render 'carts/checkout'
    end    
  end

  def show
  end

  def payment
  end

  def destroy
    @order.destroy
    redirect_to orders_path, notice: '訂單已取消' 
  end

  def transaction
      result = braintree_gateway.transaction.sale(
        :amount => "@order.total_price", 
        :payment_method_nonce => params[:payment_method_nonce],
        :options => {
        :submit_for_settlement => true
        }
      )
      redirect_to orders_path, notice: '卡結帳完成'
  end

  private
  def find_order
    @order = current_user.rescuer_orders.friendly.find(params[:id]) 
  end
  
  def order_params
    params.require(:order).permit(:recipient, :phone, :note)
  end  
end

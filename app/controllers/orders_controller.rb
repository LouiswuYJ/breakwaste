class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:show, :transaction, :destroy, :payment, :transaction]
  
  def index
    @rescuer_orders = current_user.rescuer_orders.order(created_at: :desc).page(params[:page]).per(6)
  end

  def giver
    @giver_orders = current_user.giver_orders.order(created_at: :desc).page(params[:page]).per(6)    
  end

  def payment
    @order = Order.friendly.find(params[:id])
    if @order.order_items.map {|order_item| order_item.quantity <= Food.find(order_item.food_id).quantity}.any?(false) #只要陣列有flase就notice數量不足
      redirect_to orders_path, notice: "慢了一步，已經被別人買走了！請取消訂單並至食物救援重新選購吧！"
    else
      @token = braintree_gateway.client_token.generate
    end
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
    @giver_orders.order_items.reduce(0) do |sum, order_item|
      food_id = order_item.food_id
      order_item_price = Food.find(food_id).discount_price
      @total_price = sum + order_item_price * order_item.quantity
    end
  end
  
  def create
    giver_id = current_cart.cart_foods.find(params[:order][:cart_food_id]).giver_id
    @cart_foods = current_cart.cart_foods.where(giver_id: giver_id)
    @order = current_user.rescuer_orders.new(order_params)
    @order.giver_id = giver_id
    @order.user_id = current_user.id
    @cart_foods.each do |food|
      @order.order_items << OrderItem.new(food_id: food.food_id, quantity: food.quantity, giver_id: food.giver_id, rescuer_id: current_user.id)
    end
    #把購物車裡的東西拿出來，一條一條塞入order_items 
    cart_food_id = params[:order][:cart_food_id]
    user_id = CartFood.find(cart_food_id).giver_id
    cart_foods = CartFood.where(giver_id: user_id)
    calc_total_prices_all(cart_foods)
    if @cart_foods.each {|cart_food| cart_food.quantity <= Food.find(cart_food.food_id).quantity}  #若選購的食物數量不足庫存就notice
      if @order.save
        @cart_foods.destroy_all
        redirect_to payment_order_path(@order), notice: '訂單已成立，欲檢視商品內容請至「買家訂單」。'
      else
        render "carts/checkout"
      end   
    else
      redirect_to orders_path, notice: "慢了一步，已經被別人買走了！請取消訂單並至食物救援重新選購吧！"
    end
  end

  def show
    @order.order_items.reduce(0) do |sum, order_item|
      food_id = order_item.food_id
      order_item_price = Food.find(food_id).discount_price
      @total_price = sum + order_item_price * order_item.quantity
    end
    @giver = Food.find_by(user_id: @order.giver_id)
  end

  def destroy
    @order.destroy
    redirect_to orders_path, notice: '訂單已取消' 
  end

  def transaction
    giver = Order.friendly.find(params[:id]).giver_id
    cart_foods = CartFood.where(giver_id: giver)
    order_items = current_user.rescuer_orders.find_by(slug: params[:id]).order_items

    if order_items.map {|order_item| order_item.quantity <= Food.find(order_item.food_id).quantity}.any?(false)
      redirect_to orders_path, notice: "慢了一步！您要的食物庫存數量不足喔！"
    else  
      if @order.may_pay?
        result = braintree_gateway.transaction.sale(
          :amount => @order.total_price.to_f, 
          :payment_method_nonce => params[:payment_method_nonce],
          :options => {
          :submit_for_settlement => true
          }
        )
        if result.success?
          @order.pay!
          order_items.each do |order_item|
            food_id = order_item.food_id
            @food = Food.find(food_id)          
            origin_post_quantity = @food.quantity 
            rescuer_buy_quantity = order_item.quantity
            @food.quantity = origin_post_quantity - rescuer_buy_quantity
            @food.save(validate: false)
          end
          cart_foods.destroy_all 
          redirect_to order_path, notice: '信用卡結帳完成'
        else
          redirect_to payment_order_path, notice: '付款失敗'
        end
      else
        redirect_to orders_path, notice: '訂單已完成付款'
      end
    end    
  end

  private
  def find_order
    @order = current_user.rescuer_orders.friendly.find(params[:id]) 
  end
  
  def order_params
    params.require(:order).permit(:recipient, :phone, :note)
  end  

  def hash_total_prices_all(cart_foods)
    @total_prices_all = cart_foods.reduce({}) do |rs, cf|
      rs[cf.giver_id] ||= 0
      rs[cf.giver_id] += cf.total_price
      rs
    end
  end

  def calc_total_prices_all(cart_foods)
    @order_total_price = hash_total_prices_all(cart_foods).values.sum
  end
end

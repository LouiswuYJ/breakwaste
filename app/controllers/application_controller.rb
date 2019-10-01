class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  helper_method :current_cart, :current_cart_food

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    def current_cart
      @current_cart ||= Cart.find_or_create_by(user: current_user)
    end

    def current_cart_food
      @current_cart_food ||= CartFood.find_or_create_by(cart_id: current_cart.id)
    end
end

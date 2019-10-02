Rails.application.routes.draw do
 devise_for :users, controllers: {
             registrations: 'users/registrations',
             omniauth_callbacks: "users/omniauth_callbacks"
             }

  devise_scope :user do
    get '/users' => 'users/registrations#show'
  end
  
 resources :foods do
   member do
     get :search
     put :add_to_cart
   end
 end
 root 'foods#search'

  resource :cart, only: [:show, :destroy] do
    collection do
      delete :destroy_cart
      get :checkout 
    end
  end


  resource :cart_foods, only: [:create, :update]

  resources :orders, only: [:index, :show, :create, :destroy] do

    member do
      get :payment
      post :transaction
    end
  end

  # delete '/cart/:id', to: 'cart#destroy'
  # get '/checkout', to: 'carts#checkout'
end

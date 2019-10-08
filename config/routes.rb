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

   collection do  
     get :history
   end  
 end
 root 'foods#search'

  resource :cart, only: [:show, :destroy] do
    collection do
      delete :destroy_cart
    end

    member do
      get :checkout 
    end
  end


  resource :cart_foods, only: [:create, :update]

  resources :orders, only: [:index, :show, :create, :destroy] do

    member do
      get :payment
      post :transaction
      get :giver_order
    end

    collection do
      get :giver
    end 
  end

  resources :my_tree, only: [:show]

  # delete '/cart/:id', to: 'cart#destroy'
  # get '/checkout', to: 'carts#checkout'
end

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
 resources :foods do
   member do
     get :search
   end
 end
 root 'foods#search'
end

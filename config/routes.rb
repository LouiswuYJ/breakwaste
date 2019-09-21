Rails.application.routes.draw do
  devise_for :users
 resources :foods do
   member do
     get :search
   end
 end
 root 'foods#search'
end

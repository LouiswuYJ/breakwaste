Rails.application.routes.draw do
 resources :foods do
   member do
     get :search
   end
 end
 root 'foods#search'
end

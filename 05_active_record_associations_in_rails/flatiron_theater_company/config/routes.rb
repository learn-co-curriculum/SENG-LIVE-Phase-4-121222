Rails.application.routes.draw do
 
  resources :cast_members, only: [:index, :show]
  resources :tickets, only: [:index, :show, :create]
  resources :users, only: [:index, :show]
  resources :productions, only: [ :index, :show, :create, :update, :destroy]
  # Custome Route 
 
  

end

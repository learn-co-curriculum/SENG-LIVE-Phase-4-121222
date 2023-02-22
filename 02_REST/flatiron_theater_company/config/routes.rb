Rails.application.routes.draw do
 resources :productions, only: [:index, :show]

 namespace :admin  do
  resources :productions, only: [:create, :update, :destroy]
 end

 # "/welcome" -> application -> welcome
 get "/welcome", to: "application#welcome"
 #"/greeting/<dynamic_name>"
 get "/greeting/:name", to: "application#name"

end

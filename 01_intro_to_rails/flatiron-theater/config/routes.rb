Rails.application.routes.draw do
  #resources :productions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/productions', to:'productions#index'
  get '/productions/:id', to:'productions#show'
end

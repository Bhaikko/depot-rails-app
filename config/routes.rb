Rails.application.routes.draw do
  resources :carts
  # Creating Store as Root URL of App 
  # as: option creates store_index_path and store_index_url methods for tests
  root 'store#index', as: 'store_index'

  resources :products

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  # Creating Store as Root URL of App 
  # as: option creates store_index_path and store_index_url methods for tests
  # store#index specifying class and method to use for action request
  root 'store#index', as: 'store_index'

  resources :products do
    get :who_bought, on: :member
  end

end

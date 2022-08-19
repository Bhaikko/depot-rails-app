Rails.application.routes.draw do
  root 'store#index', as: 'store_index'

  get 'admin' => 'admin#index'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users do 
    collection do
      get 'orders'
    end
  end
  resources :orders
  resources :line_items
  resources :carts
  
  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]
end

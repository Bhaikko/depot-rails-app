Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
  resources :line_items
  resources :carts

  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]

  namespace :admin do
    get 'reports', to: 'reports#index'
    get 'categories', to: 'categories#index'
    get '/', to: redirect('/admin/reports')
  end

  scope 'admin' do 
    get 'categories', to: 'categories#admin_categories'
  end

  get 'my-orders', to: 'users#orders'
  get 'my-items', to: 'users#line_items'  
end

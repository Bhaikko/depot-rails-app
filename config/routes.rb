Rails.application.routes.draw do
  scope constraints: -> (req) { req.headers['User-Agent'] !~ FIREFOX_BROWSER_REGEX } do
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
    resources :ratings
  
    resources :products, path: '/books' do
      get :who_bought, on: :member
    end
  
    resources :support_requests, only: [ :index, :update ]
    
    resources :categories do
      resources :products, path: '/books', as: 'books', constraints: { category_id: CATEGORY_ID_REGEX }
      resources :products, path: '/books', as: 'books', to: redirect('/')
    end
  
    namespace :admin do
      get 'reports', to: 'reports#index'
      get 'categories', to: 'categories#index'
      get '/', to: redirect('/admin/reports')
    end
  
    get 'my-orders', to: 'users#orders'
    get 'my-items', to: 'users#line_items'  
  end
end

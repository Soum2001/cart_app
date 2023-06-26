Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations',
    sessions:      'sessions'
  } 
  
  devise_scope :user do
  root to: 'devise/sessions#home'
  end
  
   resources :products do
    collection do
      get :my_product
    end
    collection do
      get :add_quantity
      patch :update_quantity
    end
  end
  
  namespace :admin do
    resources  :dashboard, only: [:index, :destroy, :show]
    resources :categories
  end
  
  namespace :user do
    resources :carts, only: [:index]
    resources :cart_items
    resources :orders, only: [:create, :index, :show] do
      collection do
        get :user_order_details
      end
      collection do
        get :order_status
      end
    end
    resources :profiles
    resources :success
    resources :address, only: [:new, :create, :update]
    resources :payment do
      collection do
        get :create_payment_intent
      end
    end
  end
  get '/success', to: 'payment#success'
get '/cancel', to: 'payment#cancel'
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
    # Defines the root path route ("/")
    # root "articles#index"
  end
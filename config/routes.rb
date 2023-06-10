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
  end
  
  namespace :admin do
    resources  :dashboard, only: [:index, :destroy, :show]
    resources :categories
  end
  
  namespace :user do
    resources :carts, only: [:index]
    resources :cart_items, only: [:create, :update]
    resources :orders, only: [:create, :index, :show]
    resources :profiles
    resources :success
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
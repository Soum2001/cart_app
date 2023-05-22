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

 resources :dashboard, only: [:index, :destroy, :show]
 resources :products, only: [:index]
 resources :cart, only: [:index]
 resources :cart_items, only: [:create, :update]
 resources :orders, only: [:create, :index, :show]
 resources :categories
 resources :user_profile

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

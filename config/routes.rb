Rails.application.routes.draw do
  get 'product_categories/index'
  get 'product_categories/show'
  get 'product_categories/new'
  get 'product_categories/edit'
  get 'product_categories/delete'

devise_for :users,
controllers: {
  registrations: 'registrations',
  confirmations: 'confirmations',
  sessions:      'sessions'
} 

devise_scope :user do
root to: 'devise/sessions#home'
end

 resources :dashboard, only: [:index]
 resources :products, only: [:index]
 resources :cart, only: [:index]
 resources :cart_items, only: [:create, :update]
 resources :orders, only: [:create, :index, :show]
 resources :product_categories

 get '/search', to: 'products#search', as: 'search'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

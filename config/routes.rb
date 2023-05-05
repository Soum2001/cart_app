Rails.application.routes.draw do

  devise_for :users,
  controllers: {
    registrations: 'registrations'
  } do
end

devise_scope :user do
root to: 'devise/sessions#home'
end

 resources :dashboard, only: [:index]
 resources :products, only: [:index]
 resources  :cart, only: [:index]
 resources :cart_items, only: [:create, :update]
 resources :orders, only: [:create,:index]
 resources :orders, only: [:show]
 get '/search', to: 'products#search', as: 'search'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

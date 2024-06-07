# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products do
    member do
      get 'who_bought'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '*path', to: 'application#render404', via: :all

  put 'line_items/:id/increase_quantity', to: 'line_items#increase_quantity',
                                          as: 'increase_quantity_cart'
  # Defines the root path route ("/")
  # root "posts#index"
end

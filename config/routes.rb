Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :warehouses, only:[:show, :new, :create, :edit, :update]
  resources :providers, only:[:index, :show, :new, :create] 
  resources :product_models, only:[:index, :show, :new, :create, :edit, :update]
  resources :product_bundles, only:[:index, :new, :create, :show]
  resources :categories, only:[:index, :show, :new, :create]
  resources :product_items, only:[:new]
  post '/product_items/submit', to: 'product_items#submit', as: 'submit'
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :warehouses, only:[:show, :new, :create]
  resources :providers, only:[:index, :show, :new, :create] 
  resources :product_models, only:[:show, :new, :create]
  resources :product_bundles, only:[:new, :create, :show]
end

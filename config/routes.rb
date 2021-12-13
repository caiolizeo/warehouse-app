Rails.application.routes.draw do
  root to: 'home#index'

  resources :warehouses, only:[:show, :new, :create]
  resources :providers, only:[:show, :new, :create] 
  get '/provider/all/',to: 'providers#all_providers', as: 'all_providers'
end

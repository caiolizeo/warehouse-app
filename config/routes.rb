Rails.application.routes.draw do
  root to: 'home#index'

  resources :warehouses, only:[:show, :new, :create]
  resources :providers, only:[:show, :new, :create] 
  get '/all',to: 'providers#all', as: 'all'
end

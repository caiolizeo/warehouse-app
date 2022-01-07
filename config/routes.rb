Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :warehouses, only:[:show, :new, :create, :edit, :update] do
    post 'product_entry', on: :member
  end
  resources :providers, only:[:index, :show, :new, :create] 
  resources :product_models, only:[:index, :show, :new, :create, :edit, :update]
  resources :product_bundles, only:[:index, :new, :create, :show]
  resources :categories, only:[:index, :show, :new, :create]
  resources :product_items, only:[:new]
  get '/product_items/entry', to: 'product_items#entry'
  post '/product_items/entry', to: 'product_items#process_entry'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do #versionamento de api
      resources :warehouses, only:[:index]
    end
    
  end
  

end

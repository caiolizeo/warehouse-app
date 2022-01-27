Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :warehouses, only:[:show, :new, :create, :edit, :update] do
    post 'product_entry', on: :member
    get 'add_category', on: :member
    post 'register_category', on: :member
    get 'search', on: :collection
  end
  resources :providers, only:[:index, :show, :new, :create] 
  resources :product_models, only:[:index, :show, :new, :create, :edit, :update] do
    patch 'enable', on: :member
    post 'product_entry', on: :member
  end
  resources :product_bundles, only:[:index, :new, :create, :show]
  resources :categories, only:[:index, :show, :new, :create]
  resources :product_items, only:[:new]
  get '/product_items/entry', to: 'product_items#entry'
  post '/product_items/entry', to: 'product_items#process_entry'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do #versionamento de api
      resources :warehouses, only:[:index, :show, :create]
      resources :product_models, only:[:index, :show, :create]
      resources :suppliers, only:[:index, :show, :create]
    end
    
  end
  

end

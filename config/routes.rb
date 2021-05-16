require 'sidekiq/web'

Rails.application.routes.draw do
  mount API::Base, at: "/"
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
    mount GrapeSwaggerRails::Engine, at: "/documentation"
  end
  scope "(:locale)", locale: /zh-CN/ do
    devise_for :users
    get '/users' => 'users#index'
    get '/users/:id/edit' => 'users#edit'
    patch '/users/:id/update' => 'users#update'
    get '/users/:id/new' => 'users#new'
    post '/users/:id/create' => 'users#create'
    get '/'  => 'products#index', as: :root
    mount Ckeditor::Engine => '/ckeditor'
    resources :customers
    resources :products
    resources :product_product_attribute_categories, controller: 'product/product_attribute_categories'
    resources :product_product_attributes, controller: 'product/product_attributes'
    resources :product_categories, controller: 'product/categories'
    resources :product_skus, controller: 'product/skus'
    resources :product_bundles, controller: 'product/bundles'
    resources :product_packages, controller: 'product/packages'
    resources :country_provinces, controller: 'country/provinces'

    resources :pages

    resources :orders, except: [:new, :create, :delete]

    resources :mp_links

    resources :delivery_fees

    resources :countries

    resources :gift_cards

    resources :mp_images

    resources :campaigns

    resources :douyin_customers

    resources :coupons

    resources :lucky_draws, except: [:new, :create, :delete]
    resources :lucky_draw_prizes, controller: 'lucky_draw/prizes'
    get 'lucky_draw/prizes/:id/show_code', controller: 'lucky_draw/prizes', action: 'show_code', as: :show_code

    resources :slides
    post '/slides' => 'slides#create', controller: 'slides', as: :create_slide
    patch '/slides/:id' => 'slides#update', controller: 'slides', as: :update_slide
    get '/slides/:id' => 'slides#show', controller: 'slides', as: :show_slide
    delete '/slides/:id' => 'slides#destroy', controller: 'slides', as: :delete_slide

    get '/statistics' => 'statistics#index', as: :statistic

    get '/orders/:id/synchronise', controller: 'orders', action: 'sync', as: :sync_order
    get '/orders/source/:source', controller: 'orders', action: 'index'
    get '/import_product', controller: 'products', action: 'import_product', as: :import_product
    post '/products/import' => 'products#import', controller: 'products', action: 'import'

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

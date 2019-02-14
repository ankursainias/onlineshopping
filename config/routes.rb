require 'constraints/web_constraint'
require 'constraints/api_constraint'
require 'resque/server'
require 'resque/scheduler'
require 'resque/scheduler/server'
Rails.application.routes.draw do

  namespace :admin do
    resources :deals
  end
  namespace :admin do
    resources :prices
  end
  namespace :admin do
    resources :deal_items
  end
   mount Resque::Server.new, at: "/resque"
  # API routes 
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraint.new(version: 1, default: true) do
          resources :deals, only: [:index] do
            post 'apply'
          end

          resources :stores, only: [:index] do
            get 'items'
            collection do 
              get 'categories'
              get 'customization'
            end
            resources :orders, only: [:index,:create] do
              collection do
                  post 'paypal_obj'
                  get 'paypal_cancel'
                  get 'paypal_success'
              end
            end
          end
          resources :testing, only: [] do
            collection do
              post "create_order"
              get "since_orders"
              get "deliveries"
              get "deliveries_order_for_kitchen"
            end
            member do
              get "order"
              put "order_update"
              get "last_mile_data"
            end
          end
          resources :users, only: [] do
            collection do
              post 'login'
              delete 'logout'
              get 'session_testing'
            end
          end
          resources :home,path: '', only: [] do
            collection do 
                post "add_to_cart"
                get "items"
            end
          end
    end
  end
  # Admin routes
  namespace :admin do
    resources :brands,:categories,:brand_categories,:dimensions,
              :coupons, :orders,:items,:payments,:open_hours,
              :toppings,:ingredients
    resources :stores do
       get 'items'
    end
    resources :items do 
      get 'stock'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
   resources :home, only: [:index] do
    collection do
      post 'add_to_cart'
      post 'apply_coupon'
      post 'order_now'
      delete 'delete_cart_item'
      put 'update_quantity'
      get 'checkout'
      get 'paypal_checkout'
      post 'set_payment_params'
      get 'testing'
      get 'paypal_return'
      post 'paypal_notify'
    end
   end
  get 'home/index'
	root to: "home#index"
  	  devise_for :users,
        controllers: {
              sessions: "users/sessions", 
              registrations: "users/registrations", 
              passwords: "users/passwords"
            }
  	
end

Rails.application.routes.draw do
  
  namespace :admin do
    resources :payments
  end
  namespace :admin do
    resources :items,:brands,:categories,:brand_categories,:dimensions, :coupons, :orders
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

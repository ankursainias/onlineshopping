class Api::V1::OrdersController < Api::V1::ApplicationController
	# before_action :authenticate_user!
	before_action :set_order,only: []
	before_action :set_store,only: [:index]
	before_action :set_cart, only: [:create]
	after_action  :set_cart_items, only: [:set_cart], if: -> { @cart.present? }
	after_action  :calculate_invoice, only: [:set_cart_items]
	after_action  :make_payment, only: [:create]



	def index
		begin
			@orders = @store.orders
		rescue Exception => e
				error_handling_bad_request(e)
		end

	end

	def create
		begin
		@order = @store.orders.new(order_parameters)
		@order.cart = @cart
		@order.save!
		rescue Exception => e
			error_handling_bad_request(e)
		end
		
	end

	private

	def set_cart
		if user_signed_in?
			@cart = Cart.find_or_initialize_by!(user_id: current_user.id, purchased: false)
		else
			@cart = Cart.find_or_initialize_by!(session_id: session[:session_id], purchased: false)
		end
		@cart.session_id = session[:session_id]
		@cart.save!
	end

	def set_cart_items
		params[:cart_items].each do |item|
			cart_item = @cart.cart_items.new(cart_item_params(item))
			cart_item.user = current_user if user_signed_in?
			cart_item.save!
		end
	end

	def cart_item_params
			cart_params = {}
			cart_params[:item_dimension_id] = item[:item_dimension_id]
			cart_params[:quantity] = item[:quantity]
			cart_params[:less_ingredient_ids] = item[:less_ingredient_ids].map(&:to_i)
			cart_params[:topping_ids] = item[:topping_ids].map(&:to_i)
			cart_params
	end

	def calculate_invoice
			@sub_total = @cart.sub_total
			@discount_total = 0
			@grand_total = @cart.sub_total
	end

	def order_parameters
	    order_params = {}
      order_params[:grand_total] = @grand_total
      order_params[:discount_total] = @discount_total
      order_params[:sub_total] = @sub_total
      order_params[:delivery_fee] = 0
      order_params[:expected_delivery_at] = Time.now + 30.minutes
      order_params[:user_id] = user_signed_in? ? current_user.id : nil
			order_params
	end

	def make_payment
		begin
			type = params[:payment][:type].try(:titleize)
			if type == "Cash"
				@payment = @order.cash_payment
					elsif  type == "Card"
						@payment = @order.card_payment(params,@grand_total)
							elsif type == "Paypal"
								@payment = @order.paypal_payment
							else
								raise "Please select valid payment method."
			end
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end

	def set_order
		@order = Order.find(params[:id])
	end

	def set_store
		@store = Store.find(params[:store_id])
	end

end
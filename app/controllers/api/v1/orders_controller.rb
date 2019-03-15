class Api::V1::OrdersController < Api::V1::ApplicationController
	# before_action :authenticate_user!
	include OrderCollection

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
		response  =  successful_initializer(params)
		@order
		if response.class == Hash
			render json: response
		else
			render :show
		end
		rescue Stripe::StripeError => e
		rescue Exception => e
			unsuccessful_api_call
			error_handling_bad_request(e)
		end
		
	end

	private
	
	def unsuccessful_api_call
			@order.try(:delivery_address).try(:destroy)
			@order.try(:destroy)
			@cart.try(:cart_items).try(:destroy_all)
	end

	def successful_initializer(params)
		set_cart_items(params)
		calculate_invoice
		deal_checker
		make_payment
	end


	def set_order
		@order = Order.find(params[:id])
	end

	def set_store
		@store = Store.find(params[:store_id])
	end

end
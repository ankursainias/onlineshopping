class Api::V1::OrdersController < Api::V1::ApplicationController
	# before_action :authenticate_user!
	before_action :set_order,only: []
	before_action :set_store,only: [:index,:create]
	before_action :set_cart, only: [:create]

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


	def unsuccessful_api_call
			@order.delivery_address.destroy
			@order.destroy
			@cart.cart_items.destroy_all
	end

	def successful_initializer(params)
		set_cart_items(params)
		calculate_invoice
		deal_checker
		make_payment
	end

	def paypal_obj
		begin
		 @order = Order.find(params[:orderID])
		 @cart = @order.cart.update(purchased: true)
      payment_params = {}
      payment_params[:transaction_id] = params[:payer_id]
      payment_params[:token] = params[:token]
      payment_params[:failure_message] = ""
      payment_params[:failure_code] = ""
      payment_params[:gateway_status] = params[:payment_status]
      payment_params[:pay_type] = "Paypal"
      payment_params[:fee] = params[:payment_fee].to_f
      payment_params[:currency] = params[:mc_currency]
      @payment = @order.payments.new(payment_params)
      @payment.save!
      hsh = {}
      hsh[:message] = "You order has been placed"
      render json: hsh, status: :ok
		rescue Exception => e
			raise e.message
		end
	end
 
	def paypal_success
			begin
			@payment = Payment.find_by(transaction_id: params[:paymentId])
			@payment.payer_id = params[:PayerID]
			@payment.completed = true
			@payment.save!
			@order = @payment.order
			@order.cart.update(purchased: true)
			paypal_payment = @payment.find_paypal_payment
			if paypal_payment.execute(:payer_id => params[:PayerID])
				@payment.update_attributes(gateway_status: paypal_payment.state)
				render :show
			else
				p paypal_payment.error
			  raise paypal_payment.error
			end
		rescue Exception => e
			raise e.message
		end
	end


	def paypal_cancel
		begin
			hsh = {}
			hsh[:message] = "Something went wrong. please try again."
			# raise "success paypal_cancel"
			render  json: hsh, status: :ok
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end


	private

	def set_cart
		if user_signed_in?
			@cart = Cart.find_or_initialize_by(user_id: current_user.id, purchased: false)
		else
			@cart = Cart.find_or_initialize_by(session_id: params[:session_id], purchased: false)
		end
		@cart.session_id = params[:session_id]
		@cart.save!
	end

	def set_cart_items(params)
		@cart.cart_items.destroy_all
		params[:cart_items].each do |item|
			cart_item = @cart.cart_items.new(cart_item_params(item))
			cart_item.user = current_user if user_signed_in?
			cart_item.save!
		end
	end

	def cart_item_params(item)
			cart_params = {}
			cart_params[:item_dimension_id] = item[:item_dimension_id]
			cart_params[:quantity] = item[:quantity]
			cart_params[:less_ingredient_ids] = item[:less_ingredient_ids].map(&:to_i)
			cart_params[:topping_ids] = item[:topping_ids].map(&:to_i)
			cart_params[:item_id] = item[:item_id]
			cart_params
	end

	def calculate_invoice
			@sub_total = @cart.total.round(2)
			@discount_total = 0
			@grand_total = @cart.total.round(2)
			@order.sub_total = @sub_total
			@order.grand_total = @grand_total
			@order.discount_total = @discount_total.round(2)
			@order.save!
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
					@cart.update(purchased: true)
					elsif  type == "Card"
							hsh = HashWithIndifferentAccess.new(card: params[:card])
							hsh[:grand_total] = @grand_total
							hsh[:user_type] =  user_signed_in? ? "Customer" : "Guest" 
						@payment = @order.card_payment(hsh)
							@cart.update(purchased: true)
							elsif type == "Paypal"
								hsh = {}
								hsh[:request_url] = @order.create_paypal_payment(params,root_url)
								# hsh[:request_url] = @order.paypal_payment(params,root_url)
								return hsh
							else
								raise "Please select valid payment method."
			end
		rescue PayPal::SDK::Core::Exceptions::UnsuccessfulApiCall => e
		rescue Exception => e
			raise e.message
		end
	end

	def deal_checker
		begin
			@deal = Deal.find_by(id: params[:deal][:id]) if params[:deal].present?
			if @deal.present?
				@final_cost = @deal.validate_and_apply(@cart)
				@sub_total = @final_cost[:amount].round(2)
				@discount_total = @final_cost[:discount].round(2)
				@grand_total = @final_cost[:total].round(2)
				@order.sub_total = @sub_total
				@order.grand_total = @grand_total
				@order.discount_total = @discount_total
				@order.save!
			end
		rescue Exception => e
			raise e.message
		end
	end

	def set_order
		@order = Order.find(params[:id])
	end

	def set_store
		@store = Store.find(params[:store_id])
	end

end
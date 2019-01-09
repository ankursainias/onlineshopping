class HomeController < ApplicationController
	before_action :authenticate_user!, only: []
	before_action :set_cart_item, only: [:delete_cart_item, :update_quantity]
	before_action :set_cart, only: [:apply_coupon]


  # def testing
  #   require 'paypal-sdk-rest'
  #     # include PayPal::SDK::REST

  #     PayPal::SDK::REST.set_config(
  #       :mode => "sandbox", # "sandbox" or "live"
  #       :client_id => "AbxTNFfMfDWAwKM378b0AjsNxgusy-rwlKrThbYNH18Os52JpLOTaZq_bQODiIcg8GdhUTo4o5HeE7yF",
  #       :client_secret => "EAzlb8WFOP3RRPmXwWkkeC7bFh__4vuLwnHDToTp9FdUn4QvFjy8-O8biAcIiWlD3Ae8RDnQldFhtme_")

  #     # Build Payment object
  #     @payment = PayPal::SDK::REST::Payment.new({
  #       :intent =>  "sale",
  #       :payer =>  {
  #         :payment_method =>  "paypal" },
  #       :redirect_urls => {
  #         :return_url => "http://localhost:3000/home",
  #         :cancel_url => "http://localhost:3000/home/checkout" },
  #       :transactions =>  [{
  #         :item_list => {
  #           :items => [{
  #             :name => "item",
  #             :sku => "item",
  #             :price => "5",
  #             :currency => "USD",
  #             :quantity => 1 }]},
  #         :amount =>  {
  #           :total =>  "5",
  #           :currency =>  "USD" },
  #         :description =>  "This is the payment transaction description." }]})

  #     if @payment.create
  #       @payment.id     # Payment Id
  #     else
  #       @payment.error  # Error Hash
  #     end
  # end
  def index
  	@v_pizzas = Item.veg_pizzas
  	@nv_pizzas = Item.non_veg_pizzas
  	if user_signed_in?
  		@cart = Cart.find_by(user_id: current_user.id, purchased: false)
 	else
  		@cart = Cart.find_by(session_id: session[:session_id], purchased: false)
  	end
  end

  def paypal_notify
     @cart = Cart.find(params[:invoice])
     @cart.update(purchased: true)
       address_params = {}
       address_params[:line1] = params[:address_name]
       address_params[:line2] = params[:address_street]
       address_params[:state] = params[:address_state]
       address_params[:city] = params[:address_city]
       address_params[:house_no] = ""
       address_params[:lat] = 30.687070
       address_params[:lng] = 76.850290
       address_params[:other] = params[:residence_country]
       address_params[:postal_code] = params[:address_zip]
       address =  DeliveryAddress.new(address_params)
       address.session_id = session[:session_id]
       address.lat = address.lat.to_d 
       address.lng = address.lng.to_d
       address.user_id = user_signed_in? ? current_user.id : nil 
       address.save!
       order_params = {}
       order_params[:order_status_id] = placed_id = OrderStatus.find_by(status: "PLACED").id
       order_params[:cart_id] = params[:invoice]
       order_params[:grand_total] = params[:payment_gross]
       order_params[:discount_total] = session[:discount]
       order_params[:sub_total] = session[:sub_total]
       order_params[:delivery_address_id] = address.id
       order_params[:delivery_fee] = 0
       order_params[:expected_delivery_at] = Time.now + 45.minutes
       order_params[:user_id] = user_signed_in? ? current_user.id : nil
      @current_order = Order.new(order_params)
      payment_params = {}
      payment_params[:transaction_id] = params[:payer_id]
      payment_params[:failure_message] = ""
      payment_params[:failure_code] = ""
      payment_params[:gateway_status] = params[:payment_status]
      payment_params[:pay_type] = "PayPal"
      payment_params[:fee] = params[:payment_fee].to_f
      payment_params[:pay_time] = params[:payment_date]
      payment_params[:currency] = params[:mc_currency]
      @payment = @current_order.build_payment(payment_params)
      @payment.save!
      flash[:notice] = "Your order has been placed."
      redirect_to root_url
  end

  def add_to_cart
  		item = Item.find(params[:id])

  		 if user_signed_in?
  			@cart = Cart.find_or_create_by!(user_id: current_user.id, purchased: false,user_id: current_user.id)
  			@cart_item = @cart.cart_items.create!(item_id: item.id,quantity: 1,user_id: current_user.id,item_dimension_id: params[:item_dimension_id])
  		else
  			@cart = Cart.find_or_create_by!(session_id: session[:session_id], purchased: false)
  			@cart_item = @cart.cart_items.create!(item_id: item.id,quantity: 1,item_dimension_id: params[:item_dimension_id])
  		end
  		respond_to do |format|
  			format.js
  		end
  end

  def delete_cart_item
  		@cart = @cart_item.cart
  		@cart_item.destroy
  		respond_to do |format|
  			format.js {render file: "/home/add_to_cart.js.erb"}
  		end
  end

  def update_quantity
  	 @cart = @cart_item.cart
  	 @cart_item.update(quantity: params[:quantity])	
  	 respond_to do |format|
  			format.js {render file: "/home/add_to_cart.js.erb"}
  		end	
  end

  def apply_coupon
  	begin
	  	coupon = params[:code].to_s
	  	amount = @cart.total
	  	coupon = Coupon.find_by(code: coupon)
	  	raise "Invalid coupon code" if coupon.blank?
	  	coupon.try(:failure_terms)
	  	options = {}
	  	options[:amount] = amount
	  	@final_cost = coupon.apply(options)
	  	p @final_cost
	  	respond_to do |format|
  			format.js {render file: "/home/apply_coupon.js.erb"}
  		end	
  	rescue Exception => e
  		render json: e.message, status: 400
  	end
  end

  def checkout
  end

  def order_now
       address =  DeliveryAddress.new(params[:delivery_address].permit!)
       address.session_id = session[:session_id]
       address.lat = address.lat.to_d 
       address.lng = address.lng.to_d
       address.user_id = user_signed_in? ? current_user.id : nil 
       address.save!
       order_params = {}
       order_params[:order_status_id] = placed_id = OrderStatus.find_by(status: "PLACED").id
       order_params[:cart_id] = session[:cart_id]
       order_params[:grand_total] = session[:grand_total]
       order_params[:discount_total] = session[:discount]
       order_params[:sub_total] = session[:sub_total]
       order_params[:delivery_address_id] = address.id
       order_params[:delivery_fee] = 0
       order_params[:expected_delivery_at] = Time.now + 45.minutes
       order_params[:user_id] = user_signed_in? ? current_user.id : nil
      @current_order = Order.new(order_params)
      @current_order.save!
     if user_signed_in? && @current_order.grand_total > 0 && params[:pay_type] == "Card"
        payment_params = @current_order.pay_now(params[:card])
        @payment = @current_order.build_payment(payment_params)
        @payment.save!
      else
        payment_params = {}
        payment_params[:transaction_id] = ""
        payment_params[:failure_message] = ""
        payment_params[:failure_code] = ""
        payment_params[:gateway_status] = "succeeded"
        payment_params[:pay_type] = "Cash"
        payment_params[:pay_time] = Time.now
        @payment = @current_order.build_payment(payment_params)
        @payment.save!
     end
     @cart = Cart.find(session[:cart_id])
     @cart.purchased = true
     @cart.save!
     respond_to do |format|
      flash[:notice] = "Your order has been placed."
      format.js { render :js => "window.location.href='"+home_index_path+"'"}
     end
  end


  def set_payment_params
    @cart = Cart.find(session[:cart_id])
    cart_items = []
    @cart.items.each do |cart_item|
    cart_added_item = ActiveSupport::HashWithIndifferentAccess.new
        cart_added_item[:name] = cart_item.item.name,
        cart_added_item[:description] = cart_item.item.name,
        cart_added_item[:quantity] = cart_item.quantity,
        cart_added_item[:price] = cart_item.sub_total,
        cart_added_item[:currency] = 'inr'
        cart_items.push cart_added_item
    end
    render json: cart_items
  end

  private

  def set_cart
  	@cart = Cart.find(params[:id])
  end

  def set_cart_item
  		@cart_item = CartItem.find(params[:id])
  end	

end

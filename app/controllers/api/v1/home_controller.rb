class Api::V1::HomeController < Api::V1::ApplicationController

	# Add items into cart both guest and registered customer
	  def add_to_cart
	  	begin
	  		item = Item.find(params[:id])
		  	if user_signed_in?
	  			@cart = Cart.find_or_create_by!(user_id: current_user.id, purchased: false,user_id: current_user.id)
	        @cart_item =  @cart.cart_items.find_by(item_id: item.id,user_id: current_user.id,item_dimension_id: params[:item_dimension_id])
	        if @cart_item.present?
	            @cart_item.update(quantity: @cart_item.quantity + 1)
	          else
	            @cart_item = @cart.cart_items.create(quantity: 1, item_id: item.id,item_dimension_id: params[:item_dimension_id],user_id: current_user.id)
	          end

	      else
	  			@cart = Cart.find_or_create_by!(session_id: session[:session_id], purchased: false)
	          @cart_item =  @cart.cart_items.find_by(item_id: item.id,item_dimension_id: params[:item_dimension_id])
	          if @cart_item.present?
	            @cart_item.update(quantity: @cart_item.quantity + 1)
	          else
	            @cart_item = @cart.cart_items.create(quantity: 1, item_id: item.id,item_dimension_id: params[:item_dimension_id])
	          end
	      end
	  	rescue Exception => e
	  		error_handling_bad_request(e)
	  	end
  	end

  # Display all items including regular dimensions and item dimensions	
  def items
  	begin
  		@categories = Category.all.includes(items: [:dimensions])
	  	if user_signed_in?
	  		@cart = Cart.find_by(user_id: current_user.id, purchased: false)
	 		else
	  		@cart = Cart.find_by(session_id: session[:session_id], purchased: false)
	  	end
	  	render :items, status: :ok
  	rescue Exception => e
  		error_handling_bad_request(e)
  	end

	end

end
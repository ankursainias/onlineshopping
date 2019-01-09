module ApplicationHelper

	def set_grand_total(amount,cart)
		if amount.class == Hash
			session[:grand_total] = amount[:total]
			session[:sub_total] = amount[:amount]
			session[:discount] = amount[:discount]
		else
			session[:grand_total] = amount
			session[:sub_total] = amount
			session[:discount] = 0
		end	
		session[:cart_id] = cart.id
	end
end

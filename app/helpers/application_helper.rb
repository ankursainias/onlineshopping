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
	
	# currency converision helper start
	# Note:- Default currency converision is INR to GBP
    def convert(*args)
      if args.length == 3
          convert_full(*args)
      elsif args.length == 2
          convert_full(args[0], "INR", args[1])
      else
          convert_full(args[0], "INR", "GBP")
      end
    end

    def convert_full(initial, from, to)
	    if from == to
	        return initial
	    end
	    rate =  get_rate(from, to)
	    if rate == nil
	        return nil
	    else
	        return initial*rate
	    end
    end

    def get_rate(from, to)
    url = "https://free.currencyconverterapi.com/api/v3/convert?q=#{from}_#{to}&compact=ultra"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    if response == nil
        return nil
    else
        parsed_response = JSON.parse(response)
        rate = (parsed_response["#{from}_#{to}"]).to_f
        return rate
    end
	end
	# currency helper end
end

class Api::V1::TestingController < Api::V1::ApplicationController
	before_action :authenticate_user!
	before_action :set_header, :set_credentials
	before_action :set_order, only: [:order,:order_update,:last_mile_data]
	def create_order
		begin
			@order = Order.new(system_id: Order.set_system_id)
			set_order_values(@order)
			route = 'https://private-3643a-orderlordapi.apiary-mock.com/api/v1/jobs'
			respose =  HTTParty.post(route, body: @body, :headers => @headers)
			p respose
			parsed_response = respose.parsed_response.symbolize_keys!
			if 	parsed_response[:success] == "true"
				@order.tracker_hash = parsed_response[:tracker_hash]
				@order.save!
			end
			render json: @order, status: :ok
		rescue Exception => e
			error_handling_bad_request(e)
		end
		
	end

	def since_orders
		begin
			route = "https://private-3643a-orderlordapi.apiary-mock.com/api/v1/jobs"
			response = RestClient.get(route, @headers)
			p response
			render json: response, status: :ok
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end

	def order
		begin
		route = 'https://private-3643a-orderlordapi.apiary-mock.com/api/v1/jobs/'+ @order.system_id
		response = RestClient.get(route, @headers)
		# response =  HTTParty.get(route, :headers => @headers)
		# puts parsed_response
		render json: response, status: :ok	
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end

	def order_update
		begin
		route = 'https://private-3643a-orderlordapi.apiary-mock.com/api/v1/jobs/'+@order.system_id
		set_order_values(@order)
		response = RestClient.put(route,@body, @headers)
		render json: response, status: :ok
		# render :create_order,status: :ok
		rescue Exception => e
			error_handling_bad_request(e)
		end
		
	end

	def last_mile_data
		begin
			route = 'https://private-3643a-orderlordapi.apiary-mock.com/api/v1/jobs/'+@order.tracker_hash+'/last_mile_data'
			response = RestClient.get(route, @headers)
			puts response
			render json: response, status: :ok
		rescue Exception => e
			error_handling_bad_request(e)
		end
		
	end

	def deliveries
		begin
			route = 'https://private-3643a-orderlordapi.apiary-mock.com/api/v1/deliveries'
			response = RestClient.get(route, @headers)
			puts response
			render json: response, status: :ok
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end

	def deliveries_order_for_kitchen
		begin
			route = 'https://private-3643a-orderlordapi.apiary-mock.com/api/v1/kitchen'
			response = RestClient.get(route, @headers)
			puts response
			render json: response, status: :ok
		rescue Exception => e
		  error_handling_bad_request(e)
		end
	end



	def set_order_values(order)
		@body =  {
	      "order": {
	        "ordering_system_id": order.system_id,
	        "cancelled_at": "2012-12-02T14:30:09+08:00",
	        "created_at": "2012-12-02T14:00:09+08:00",
	        "delivery_time": "60",
	        "feedback_url": "test.sk/feedback",
	        "timed_order": "1",
	        "expected_delivery_at": "2012-12-02T15:00:09+08:00",
	        "note": "need chopsticks, doorbell isnt working",
	        "price": {
	            "delivery_fee": 2.00,
	            "sub_total": 144.00,
	            "vat_total": 28.80,
	            "discount_total": 0,
	            "grand_total": 174.80
	        },
	        "venue": {
	            "name": "Sushi Time, Apollo",
	            "ordering_system_id": "id-of-restaurant-in-ordering-system"
	        },
	        "customer": {
	            "first_name": "Fernando",
	            "last_name": "Fonseca",
	            "mobile_phone": "+42121345789",
	            "email": "fernandofonseca@gmail.com",
	            "address": {
	                "line1": "Local street",
	                "line2": "More street info",
	                "number": "28",
	                "other": "Other address info",
	                "city": "Berlin",
	                "postcode": "10987",
	                "longitude": 43.1,
	                "latitude": 18.7
	            }
	        },
	        "payment": {
	            "type": "cash",
	            "paid": "0"
	        },
	        "products": [
	            {
	                "ordering_system_id": "id-of-product-1-in-ordering-system",
	                "name": "salmon",
	                "price_unit": 12.00,
	                "price_total": 24.00,
	                "price_tax": 1.4,
	                "tax": 13,
	                "quantity": 2
	            },
	            {
	                "ordering_system_id": "id-of-product-2-in-ordering-system",
	                "name": "tenderloin steak",
	                "price_unit": 120.00,
	                "price_total": 120.00,
	                "price_tax": 1.4,
	                "tax": 13,
	                "quantity": 1
	            }
	        ]
	      }
    	}.to_json
	end

	private

	def set_order
		@order  = Order.find(params[:id])
	end

	def set_header
		@headers = { 'Content-Type' => 'application/json', "token" => "1234567890", "password" => "klJKshhC7Yzshzuv", "Accept" => "application/json"}
	end

	def set_credentials
		
		@credentials = {

		  "token": "1234567890",
		  "password": "klJKshhC7Yzshzuv"
		}
	end

end
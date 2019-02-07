class Api::V1::ApplicationController < ActionController::API
	before_action :set_prequest

	# skip_before_action :verify_authenticity_token
	# before_action :authenticate_api_user

	def set_prequest
	headers['Access-Control-Allow-Origin'] = '*'
	headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
	headers['Access-Control-Request-Method'] = '*'
	headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	end

	# Authenticate current user
	def authenticate_api_user
		begin
			raise "No token" if request.headers["HTTP_APISECRET"].blank?
			@current_api_user = User.find_by_api_secret(request.headers["HTTP_APISECRET"])			
			raise "user_not_found" if @current_api_user.nil?
			rescue Exception => e
		 		puts "error_exception #{Time.now} #{e.message}"
				err_hash={}
				err_hash[:error]=e.message
				status = :unauthorized
				render json: err_hash.to_json, status: status
		 	end
	end

	# Error handling
	def error_handling_bad_request(e)
		err_hsh = HashWithIndifferentAccess.new
		err_hsh[:message] = e.message
		err_hsh[:humanize] = e.message.humanize
		err_hsh[:error_trace] = e.backtrace
		render json: err_hsh, status: :bad_status
	end
	
end
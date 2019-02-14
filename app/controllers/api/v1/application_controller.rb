class Api::V1::ApplicationController < ActionController::API
	before_action :set_prequest,:set_api_format
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

	def set_api_format
		request.format = :json
	end



	# Error handling
	def error_handling_bad_request(e)
		puts "Exception Raised on #{Time.now} #{e.message}"
		ary_errors = []
		ary_errors_obj = {}
		ary_errors_obj[:domain] = "usageLimits"
		ary_errors_obj[:reason] = e.message
		ary_errors_obj[:message] = e.message.humanize
		ary_errors_obj[:extendedHelp] = ""
		ary_errors.push(ary_errors_obj)
		error_obj = {}
		error_obj[:errors] = ary_errors
		error_obj[:code] = 400
		error_obj[:message] = e.message.humanize
		err_hash = {}
		err_hash[:error] = error_obj 
		err_hash[:backtrace] = e.backtrace 
		render :json => err_hash.to_json, status: :bad_request
	end
	
end
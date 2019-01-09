class ApplicationController < ActionController::Base
 before_action :authenticate_user!
 before_action :set_session
 skip_before_action :verify_authenticity_token
 private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    home_index_path
  end

  protected
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || home_index_path
  end

  def set_session
  	p session[:session_id]
  	session[:old_session] = session[:session_id] unless current_user.present?
  end

end

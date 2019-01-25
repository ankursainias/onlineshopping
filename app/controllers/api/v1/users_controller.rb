class Api::V1::UsersController < Api::V1::ApplicationController
  # acts_as_token_authentication_handler_for User, except: [:login,:logout]
  # before_action :authenticate_user!, except: [:login,:logout]

  # Customer Login Api
  def login
    begin
      resource = User.find_by_email(params[:email])
      raise "Email is Invalid" if resource.blank?
      if resource&.valid_password?(params[:password])
        sign_in(resource_name, resource)
        render json: resource.as_json(only: [:id,:email,:authentication_token]), status: :created
      else
        # head(:unauthorized)
        raise "Password is Invalid"
      end
    rescue Exception => e
      err_hsh = HashWithIndifferentAccess.new
      err_hsh[:message]  = e.message
      render json: err_hsh, status: :unauthorized
    end
  end

  def resource_name
    :user
  end
  
  def warden
    request.env['warden']
  end

  # Customer logout api
  def logout
    current_user.update authentication_token: nil
    warden.logout
    hsh = HashWithIndifferentAccess.new
    hsh[:message] = "logout successfully"
    render json: hsh , status: :ok
  end

end
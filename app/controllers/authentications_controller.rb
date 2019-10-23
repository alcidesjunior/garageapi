class AuthenticationsController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 1.month.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user_id: @user.id }, status: :ok
    else
      render json: { error: 'User invalid' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
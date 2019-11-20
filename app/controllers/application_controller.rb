class ApplicationController < ActionController::API
  @current_user = ""
  OneSignal::OneSignal.user_auth_key = "ZTQ5YzYyYzEtZmJkMi00ZGM4LWE3M2YtNWVhMjY0YTc2OWMz"
  OneSignal::OneSignal.api_key = "NTAzNTYyMDUtOTJhMi00MjlkLWIzZDUtZmM0YmQ4ZDIxYWVh"
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find_by_id(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { result: "Token invalid." }, status: :unauthorized
    end
  end

  # def current_user
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header
  #
  #
  #   begin
  #     @decoded = JsonWebToken.decode(header)
  #     @current_user = User.find_by_id(@decoded[:user_id])
  #     return @current_user
  #   rescue
  #     render json: {result: "Unauthorized"}
  #   end
  # end
end

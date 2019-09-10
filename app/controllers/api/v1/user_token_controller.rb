module Api
  module V1
    class UserTokenController < Knock::AuthTokenController
      skip_before_action :verify_authenticity_token
      # rescue_from Knock.not_found_exception_class_name, with: :bad_request
      #
      # def bad_request
      #   render json: { error: "Invalid email address/password" }, status: :bad_request
      # end
    end
  end
end

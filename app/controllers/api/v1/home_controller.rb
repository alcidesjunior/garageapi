module Api
  module V1
    class HomeController < ApplicationController
      # before_action :authorize_request
      def index
        # all
        render json: {result: OneSignal::Player.all({app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc"})}
      end
    end

  end
end

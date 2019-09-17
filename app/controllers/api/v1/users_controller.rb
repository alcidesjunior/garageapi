module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, only: [:index,:current, :update, :logout]
      before_action :authorize_as_admin, only: [:destroy]
      before_action :authorize, only: [:update]

  #https://medium.com/@ciphitech/token-based-authentication-api-in-rails-with-the-help-of-jwt-and-knock-5715bc766936
      def index
          render json: { users: User.all.as_json(:except =>[:password_digest]) }
        # render json: {status: 200, msg: "Logged! as #{current_user.name}"}
      end

      def current
        current_user.update!(last_login: Time.now)
        render json: {current_user: current_user}
      end

      def show
        @user = User.find(params[:id])
        @garages = @user.garages.as_json(:include => :address)
        render json: {user: @user.as_json(:include => :addresses), garages: @garages}#, address: @user_address, garages: @garages}
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: {status: :ok, msg: 'User was created!'}
        end
      end
      def update
        puts "=======chamando"
      end
      private

      def user_params
        params.require(:user).permit(:name,:email,:document_type,:document_number,:password,:role, :isActive)
      end
    end
  end
end

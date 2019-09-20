module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, only: [:index,:current, :update, :logout]
      before_action :authorize_as_admin, only: [:destroy]
      before_action :authorize, only: [:update]

      def index
          render json: { users: User.all.as_json(:except =>[:password_digest]) }
      end

      def current
        current_user.update!(last_login: Time.now)
        render json: {current_user: current_user}
      end

      def show
        @user = User.find(params[:id])
        @garages = @user.garages.as_json(:include => [:address, :comments])

        _acumulateRate = 0

        @garages.each do |g|
          if g["comments"] != nil
            g["comments"].each do |c|
              _acumulateRate += c["rating"]
            end
            g[:average] = ((_acumulateRate/g["comments"].count).to_f).round(2)
            _acumulateRate = 0
          end
        end

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

      def comment_average
      end
    end
  end
end

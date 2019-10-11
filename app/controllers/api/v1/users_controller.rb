module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, only: [:index,:current, :update, :logout]
      before_action :authorize_as_admin, only: [:destroy]
      before_action :authorize, only: [:update]
      before_action :set_user, only: [:show]

      def index
          render json: { result: User.all.as_json(:except =>[:password_digest]) }
      end

      def current
        current_user.update!(last_login: Time.now)
        render json: {result: current_user}
      end

      def show
        # @garages = @user.garages.as_json(:include => [:address])#, :comments, :parking])

        # _acumulateRate = 0
        #
        # @garages.each do |g|
        #   if g["comments"] != nil
        #     g["comments"].each do |c|
        #       _acumulateRate += c["rating"]
        #     end
        #     g[:average] = ((_acumulateRate/g["comments"].count).to_f).round(2)
        #     _acumulateRate = 0
        #   end
        # end
        puts
        if @user.role == "ROLE_GD"
          render json: {result: @user.as_json(:include => [:addresses,:vehicle],:except =>[:password_digest])}#, garages: @garages}#, address: @user_address, garages: @garages}
        else
          render json: {result: @user.as_json(:include => [:addresses],:except =>[:password_digest])}
        end
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: {result: user.except(:password) , message: 'User was created!'}
        end
      end
      def update
        puts "=======chamando"
      end
      private

      def user_params
        params.require(:user).permit(:name,:email,:document_type,:document_number,:password,:role,:busy_space, :isActive, :lat, :long)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end

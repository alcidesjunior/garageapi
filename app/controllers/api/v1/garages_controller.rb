module Api
  module V1
    class GaragesController < ApplicationController
      before_action :authenticate_user, only: [:index, :update, :logout]


      def index
        render json: { garage: Garage.all.as_json }
      end

      def show
      end

      def new
      end

      def edit
      end

      def create
      end

      def update
      end

      def destroy
      end

      private
      def garage_params
        params.require(:garage).permit(:description, :parking_spaces, :price,
        :photo1,:photo2,:photo3,:address,:address_id)
      end
    end
  end
end

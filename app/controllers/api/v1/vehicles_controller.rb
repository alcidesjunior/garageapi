module Api
  module V1
    class VehiclesController < ApplicationController
      before_action :authenticate_user, only: [:index,:current, :update, :logout]
      before_action :authorize_as_admin, only: [:destroy]
      before_action :authorize, only: [:update]
      before_action :set_vehicle, only: [:show]

      def create
        vehicle = Vehicle.new(vehicle_params)
        if vehicle.save
          render json: {result: 'Vehicle was created!'}
        else
          render json: {result: "Error when try add vehicle"}
        end
      end

      private
      def vehicle_params
        params.require(:vehicle).permit(:model,:chassi,:license_plate,:year, :driver_license, :user_id)
      end

      def set_vehicle
        @user = Vehicle.find(params[:id])
      end
    end
  end
end

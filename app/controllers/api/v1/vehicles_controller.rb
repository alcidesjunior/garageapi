module Api
  module V1
    class VehiclesController < ApplicationController
      before_action :authorize_request
      before_action :authorize_as_admin, only: [:destroy]
      before_action :authorize, only: [:update]
      before_action :set_vehicle, only: [:show]

      def create
        vehicle = Vehicle.new(vehicle_params)
        if vehicle.save
          render json: {result: vehicle}
        else
          render json: {notice: vehicle.errors.full_messages}
        end
      end

      def update
        if vehicle = Vehicle.update(params[:id],vehicle_params)
          render json: {result: vehicle}
        else
          render json: {notice: vehicle.errors.full_messages}
        end
      end

      private
      def vehicle_params
        params.permit(:model,:chassi,:license_plate,:year, :driver_license, :user_id)
      end

      def set_vehicle
        @user = Vehicle.find(params[:id])
      end
    end
  end
end

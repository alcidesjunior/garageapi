module Api
  module V1
    class ParkingsController < ApplicationController
      before_action :authenticate_user, only: [:index,:create,:show,:current, :update, :logout]
      before_action :set_parking, only:[:show,:update,:destroy]

      def create
          if garage =  Garage.find_by_id(parking_params["garage_id"])
            #ensuring you have a vacancy available
            if garage.busy_space < garage.parking_spaces
              @parking = Parking.new(parking_params)
              if @parking.save
                garage.busy_space = garage.busy_space + 1
                garage.save
                render json: { result: @parking.as_json(:except =>[:user_id])}
              else
                render json:  {result: @parking.errors}
              end
            else
              render json: {result: "Sorry, no vacancies."}
            end
          else
            render json: {result: "Error when try parking: Garage not found."}
          end
      end

      def show
        if @parking
          render json: {result: @parking.as_json(:except =>[:user_id])}
        else
          render json: {result: "Parking was not found."}
        end
      end

      def update
        @parking = Parking.update(params[:id],parking_paramsß)
        render json: {result: @parking}
      end


      private
        def parking_params
          params.permit(:garage_owner_id,:driver_id,:price,:license_plate,:start,:end,:user_id,:vehicle_id,:garage_id)
        end

        def set_parking
          unless @parking = Parking.find_by_id(params[:id])
            render json: {error: "Parking not found"}
          end
        end
    end
  end
end

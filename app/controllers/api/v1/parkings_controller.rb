module Api
  module V1
    class ParkingsController < ApplicationController

      before_action :set_parking, only:[:show,:update,:destroy]

      def create
          if garage =  Garage.find_by_id(parking_params["garage_id"])
            #ensuring you have a vacancy available
            if garage.busy_space < garage.parking_spaces
              @parking = Parking.new(parking_params)
              if @parking.save
                garage.busy_space = garage.busy_space + 1
                garage.save
                render json: { result: @parking, status: :created, notice: 'Parking was successfully created.'}
              else
                render json:  {result: @parking.errors, status: :unprocessable_entity}
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
          render json: {parking: @parking}
        else
          render json: {result: "Parking was not found."}
        end
      end


      private
        def parking_params
          params.require(:parking).permit(:garage_owner_id,:driver_id,:price,:license_plate,:start,:user_id,:vehicle_id,:garage_id)
        end

        def set_parking
          unless @parking = Parking.find_by_id(params[:id])
            render json: {error: "Parking not found"}
          end
        end
    end
  end
end

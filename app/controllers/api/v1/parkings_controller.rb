module Api
  module V1
    class ParkingsController < ApplicationController
      before_action :authorize_request
      before_action :set_parking, only:[:show,:update,:destroy]

      def index
        @parking = Parking.all
        render json: {result: @parking}
      end

      def user_parking
        _filter = params[:show]
        _filter = "all" if _filter.nil?
        if @current_user.role == "ROLE_GD"
          if _filter == "current"
            parking = Parking.find_by(:driver_id=> @current_user.id, :end=>nil)
            render json: {result: parking.as_json(:except=>[:user_id])}
          elsif _filter == "all"
            parking = Parking.where(:driver_id=> @current_user.id)
            render json: {results: parking}
          end
        else
          render json: {notice: "This is not a driver"}
        end
      end
      def create
        puts "================="
        puts parking_params["garage_id"]
        puts "-================"
          if garage =  Garage.find_by_id(parking_params["garage_id"])
            #ensuring you have a vacancy available
            if garage.busy_space < garage.parking_spaces
              parking_params["user_id"] = parking_params["driver_id"]
              @parking = Parking.new(parking_params)

              if @parking.save
                garage.busy_space = garage.busy_space + 1
                garage.save
                render json: { result: @parking.as_json(:except =>[:user_id])}
              else
                render json:  {result: @parking.errors}
              end
            else
              render json: {notice: "Sorry, no vacancies."}
            end
          else
            render json: {notice: "Error when try parking: Garage not found."}
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

        @parking = Parking.update(params[:id],parking_params)
        garage = Garage.find_by(:id=>@parking.garage_id)
        if garage.busy_space > 0
          garage.busy_space = (garage.busy_space - 1)
          garage.save
        end
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

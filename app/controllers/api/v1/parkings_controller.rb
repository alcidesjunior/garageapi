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
            parking = Parking.find_by(:driver_id=> @current_user.id, :status=> true)
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
          if garage =  Garage.find_by_id(parking_params["garage_id"])
            #ensuring you have a vacancy available
            if garage.busy_space < garage.parking_spaces
              parking_params["user_id"] = parking_params["driver_id"]
              @parking = Parking.new(parking_params)

              if @parking.save
                #Params app_id,user_auth,api_key
                noty = Notifications.new("d5d9db25-332e-4f14-9dd2-1feec0fbf3cc","ZTQ5YzYyYzEtZmJkMi00ZGM4LWE3M2YtNWVhMjY0YTc2OWMz","NTAzNTYyMDUtOTJhMi00MjlkLWIzZDUtZmM0YmQ4ZDIxYWVh")
                noty.toGarage(@parking.garage_owner_id,@parking.driver_id,@parking.id)
                render json: { result: @parking.as_json(:except =>[:user_id])}
              else
                render json:  {notice: @parking.errors}
              end
            else
              render json: {notice: "Sorry, no vacancies"}
            end
          else
            render json: {notice: "Error when try parking: Garage not found"}
          end
      end

      def show
        if @parking
          render json: {result: @parking.as_json(:except =>[:user_id])}
        else
          render json: {notice: "Parking was not found."}
        end
      end

      def update

        @parking = Parking.update(params[:id],parking_params)
        garage = Garage.find_by(:id=>@parking.garage_id)
        # if garage.busy_space > 0
           if parking_params[:status] != nil
             noty = Notifications.new("75ad7e1f-f43a-4382-ada0-50553d07b475","ZTQ5YzYyYzEtZmJkMi00ZGM4LWE3M2YtNWVhMjY0YTc2OWMz","ZThjNjM4OTAtYTcwNi00ZTY4LTg1ZDQtYzQ4NzU2MGRkMDgy")
             if parking_params[:status] == true
               garage.busy_space = garage.busy_space + 1
               garage.save
               # 75ad7e1f-f43a-4382-ada0-50553d07b475 app id
               # ZTQ5YzYyYzEtZmJkMi00ZGM4LWE3M2YtNWVhMjY0YTc2OWMz user auth
               # ZThjNjM4OTAtYTcwNi00ZTY4LTg1ZDQtYzQ4NzU2MGRkMDgy api key
               #dono de garagem aceitou o estacionamento push para o motorista
               #instanciar a classe de push e mandar para o motorista
               noty.toDriver(@parking.driver_id, "Pode se dirigir a garagem.",true)
             else
               #dono de garagem rejeitou o estacionamento mandar apenas a push
               #para o motorista
               puts "========> parking id driver #{@parking.driver_id.class}"
               noty.toDriver(@parking.driver_id, "A garagem não aceitou sua solicitação.",false)
               #instanciar a classe de notification e mandar push pro motorista
             end
           else
             #concluindo estacionamento
             if garage.busy_space>0
               garage.busy_space = (garage.busy_space - 1)
               garage.save
             end
           end
        # end
        render json: {result: @parking}
      end


      private
        def parking_params
          puts "======="
          puts params[:parking]
          puts "======="
          params.permit(:garage_owner_id,:driver_id,:price,:license_plate,:start,:end,:user_id,:vehicle_id,:garage_id,:permanence_duration,:price_per_hour,:status)
        end

        def set_parking
          unless @parking = Parking.find_by_id(params[:id])
            render json: {notice: "Parking not found"}
          end
        end
    end
  end
end

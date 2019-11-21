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
          if garage =  Garage.find_by_id(parking_params["garage_id"])
            #ensuring you have a vacancy available
            if garage.busy_space < garage.parking_spaces
              parking_params["user_id"] = parking_params["driver_id"]
              @parking = Parking.new(parking_params)

              if @parking.save
                players = OneSignal::Player.all(params:{app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc"})
                player_id = JSON.parse(players.body)["players"][2]


                garage.busy_space = garage.busy_space + 1
                garage.save
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
        if garage.busy_space > 0
          players = OneSignal::Player.all(params:{app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc"})
          player_id = JSON.parse(players.body)["players"][2]

          notification = OneSignal::Notification.create(params:{
            app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc",
            contents:{
              en:"Se eu tivesse passado vcs nao teria passado - Oliveira, Mateus"

            },
            ios_category:"PARKING_INVITATION",
            buttons:[{id:"1",text:"Acept",icon:"some"},{id:"2",text:"Reject",icon:"some"}],
            include_player_ids:[player_id["id"].to_s],
            action: "like-btn",
            content_available:true,
            data:{
              name: "Alcides",
              idade: 25
            }
          })
          render json: {
            result: "Notication was sended #{player_id['id']}"
          }
          garage.busy_space = (garage.busy_space - 1)
          garage.save
        end
        render json: {result: @parking}
      end


      private
        def parking_params
          puts "======="
          puts params[:parking]
          puts "======="
          params.permit(:garage_owner_id,:driver_id,:price,:license_plate,:start,:end,:user_id,:vehicle_id,:garage_id,:permanence_duration,:price_per_hour)
        end

        def set_parking
          unless @parking = Parking.find_by_id(params[:id])
            render json: {notice: "Parking not found"}
          end
        end
    end
  end
end

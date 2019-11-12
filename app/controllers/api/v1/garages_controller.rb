module Api
  module V1
    class GaragesController < ApplicationController
      before_action :authorize_request, except: [:index, :show]
      before_action :set_garage, only:[:show,:update,:destroy]

      def index
        @garages = Garage.all.select(:id,:price,:lat,:long,:parking_spaces,:busy_space).joins([:address])
        render json: {results: @garages}
      end

      def garageByUserId
        garages = Garage.where(:user_id=>params[:id],:role=>"ROLE_GO")
        garages = garages.as_json(:include=> [:address,:comments,:parking])
        # garages = garages.each {|e|
        #   if e["parking"] != nil
        #     #removendo garagens que não estão em aberto
        #     garages.delete(e) if e["parking"]["end"].nil?
        #   end
        # }
        render json: {results: garages}
      end

      def show
        garage = @garage.as_json(:include=> [:address,:comments])
        _acumulateRate = 0

         if garage["comments"] != nil
           garage["comments"].each do |c|
             _acumulateRate += c["rating"]
           end
           if _acumulateRate > 0
             garage[:average] = ((_acumulateRate/garage["comments"].count).to_f).round(2)
           else
             garage[:average] = nil
           end
           _acumulateRate = 0
         else
           garage[:average] = nil
         end

        render json: {result: garage}
      end

      def create
        address_id = garage_params["address_id"]
        @garage = Garage.new(garage_params.except(:address_id))
        puts ">>>>>>>>>>#{address_id}"

        # if @garage.save
          # puts ">>>>>>>>#{@garage.id}<<<<<<<<"
          #eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1LCJleHAiOjE1NzYwNzU5NjV9.PgWfEEoePy1cfrNm-4MZTqFj5-YhZHDHgjrfHxTH_rI
          #associating garage to address
          # address = Address.find_by(id: address_id)
          if Address.exists?(address_id)
            @garage.save
            address = Address.find_by(id: address_id)
            address.garage_id = @garage.id
            address.save
            response.status = 201
            render json: {result: @garage}
          else
            response.status = 404
            render json: {notice: "Address not found."}
          end
        # else
        #   render json:  {notice: @garage.errors.full_messages}
        # end
      end

      def update
        @garage = Address.find(params[:id])
        @garage.save
        render json: {result: @garage}
      end

      def destroy
        #implementar isActive e setar para false
        # @garage.destroy
        # render json: {result: 'Garage was deleted with successfully.'}
      end

      private

      def garage_params
        params.permit(:description, :parking_spaces, :price,
        :photo1,:photo2,:photo3,:address_id,:user_id)
      end

      def set_garage
        @garage = Garage.find(params[:id])
      end
    end
  end
end

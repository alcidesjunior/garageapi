module Api
  module V1
    class GaragesController < ApplicationController
      before_action :authenticate_user, only: [:index, :update, :logout]
      before_action :set_garage, only:[:show,:update,:destroy]

      def index

        @garages = Garage.all.select(:id,:price,:lat,:long,:parking_spaces,:busy_space).joins([:address])
        render json: {garages: @garages}

      end

      def show
        render json: {garage: @garage.as_json(:include=> [:address,:comments])}
      end

      def create
        address_id = garage_params["address_id"]
        puts "AQUI>>>>>>>>>>>>#{address_id}"
        @garage = Garage.new(garage_params.except(:address_id))

        if @garage.save
          #associating garage to address
          address = Address.find(address_id)
          address.garage_id = @garage.id
          address.save
          render json: { result: @garage, status: :created, notice: 'Garage was successfully created.'}
        else
          render json:  {result: @garage.errors, status: :unprocessable_entity}
        end
      end

      def update
        @garage = Address.find(params[:id])
        @garage.save
        render json: {result: @garage, status: :updated, notice: 'Garage was updated with successfully.'}
      end

      def destroy
        @garage.destroy
        render json: {notice: 'Garage was deleted with successfully.'}
      end

      private

      def garage_params
        params.require(:garage).permit(:description, :parking_spaces, :price,
        :photo1,:photo2,:photo3,:address_id,:user_id)
      end

      def set_garage
        @garage = Garage.find(params[:id])
      end
    end
  end
end

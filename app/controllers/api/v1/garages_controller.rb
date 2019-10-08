module Api
  module V1
    class GaragesController < ApplicationController
      before_action :authenticate_user, only: [:index, :update, :logout]
      before_action :set_garage, only:[:show,:update,:destroy]

      def index
        render json: { garage: Garage.all.as_json(:include=>[:address]) }
      end

      def show
        render json: @garage
      end

      def create
        @garage = Garage.new(garage_params)

        if @garage.save
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
        :photo1,:photo2,:photo3,:address_id)
      end

      def set_garage
        @garage = Garage.find(params[:id])
      end
    end
  end
end

module Api
  module V1
    class AddressesController < ApplicationController
      before_action :authenticate_user, only: [:index, :show,:create, :update, :destroy]
      before_action :set_address, only: [:show, :update, :destroy]

      def index
        @addresses = Address.all
        render json: {result: @addresses}
      end

      def show
        render json: {result: @address}
      end

      def create
        @address = Address.new(address_params)

        if @address.save
          render json: {result: @address, status: :created, notice: 'Address was successfully created.'}
        else
          render json: {result: @address.errors, status: :unprocessable_entity}
        end
      end

      def update
        @address = Address.update(params[:id], address_params)#Address.find(params[:id])
        @address.save
        render json: @address, status: :updated, notice: 'Address was updated with successfully.'
      end

      def destroy
        @address.destroy
        render json: {notice: 'Adress was deleted with successfully.'}
      end

      private

        def set_address
          @address = Address.find(params[:id])
        end

        def address_params
          params.require(:address).permit(:zip, :street, :number,:city,:uf,:complement,:user_id,:garage_id)
        end
    end
  end
end

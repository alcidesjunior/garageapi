module Api
  module V1
    class AddressesController < ApplicationController
      before_action :authenticate_user, only: [:index, :show,:create, :update, :destroy]
      before_action :set_addres s, only: [:show, :update, :destroy]

      def index
        @addresses = Address.all
        render json: {results: @addresses}
      end

      def show
        render json: {result: @address}
      end

      def create
        @address = Address.new(address_params)

        if @address.save
          render json: {result: @address}
        else
          render json: {result: @address.errors}
        end
      end

      def update
        @address = Address.update(params[:id], address_params)#Address.find(params[:id])
        @address.save
        render json: {result: @address, status: :updated, notice: 'Address was updated with successfully.'}
      end

      def destroy
        @address.destroy
        render json: {result: 'Adress was deleted with successfully.'}
      end

      private

        def set_address
          @address = Address.find(params[:id])
        end

        def address_params
          params.require(:address).permit(:zip, :street, :number,:city,:uf,:complement,:user_id,:garage_id,:lat,:long)
        end
    end
  end
end

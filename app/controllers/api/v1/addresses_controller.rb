module Api
  module V1
    class AddressesController < ApplicationController
      before_action :authorize_request
      before_action :set_address , only: [:show, :update, :destroy]

      def index
        @addresses = Address.all
        render json: {results: @addresses}
      end

      def show
        render json: {result: @address}
      end

      def create
        @address = Address.new(address_params)
        if User.find_by(id: address_params["user_id"])
          if @address.save
            render json: {result: @address}
          else
            render json: {notice: @address.errors.full_messages}
          end
        else
          render json: {notice: "Please, insert an existing User."}
        end
      end

      def update
        if @address = Address.update(params[:id], address_params)
          render json: {result: @address}
        else
          render json: {notice: @address.error.full_messages}
        end
      end

      def destroy
        #implementar para alterar o status de isActive para false, significando que nao será mais listado.
        # @address.destroy
        # render json: {result: 'Adress was deleted with successfully.'}
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

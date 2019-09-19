module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user, only: [:index,:comments,:current, :update, :logout]
      before_action :set_comment, only: [:update,:show,:destroy]


      def comments
        @comments = Comment.where(:garage_id=>params[:garage_id])
        render json: {comments: @comments}
      end

      def show
      end

      def update
      end

      def destroy
      end

      private

        def comments_params
          params.require(:comments).permit(:from_user_id,:to_user_id,:garage_id,:title,:message,:rating)
        end

        def set_comment
          @comment = Comment.find(params[:id])
        end
    end
  end
end

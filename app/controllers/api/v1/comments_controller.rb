module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_request, except: [:comments]
      before_action :set_comment, only: [:update,:show,:destroy]


      def comments
        @comments = Comment.where(:garage_id=>params[:garage_id])
        render json: {results: @comments}
      end

      def create
        @comment = Comment.new(comments_params)
        if @comment.save
          render json: {result: @comment}
        else
          render json: {notice: @comment.errors.full_messages}
        end
      end

      def show
      end

      def update
      end

      def destroy
      end

      private

        def comments_params
          params.permit(:from_user_id,:to_user_id,:garage_id,:title,:message,:rating)
        end

        def set_comment
          @comment = Comment.find(params[:id])
        end
    end
  end
end

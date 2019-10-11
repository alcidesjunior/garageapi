class HomeController < ApplicationController
  before_action :authenticate_user, only: [:comments,:current, :update, :logout]
  def index
    render json: {result: "You are not logged in!"}
  end
end

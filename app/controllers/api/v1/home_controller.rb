class HomeController < ApplicationController
  before_action :authorize_request
  def index
    render json: {result: "You are not logged in!"}
  end
end

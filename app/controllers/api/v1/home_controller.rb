module Api
  module V1
    class HomeController < ApplicationController
      # before_action :authorize_request
      def index
        # all
        players = OneSignal::Player.all(params:{app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc"})
        player_id = JSON.parse(players.body)["players"][0]

        notification = OneSignal::Notification.create(params:{
          app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc",
          contents:{
            en:"Se eu tivesse passado vcs nao teria passado - Oliveira, Mateus"
          },
          include_player_ids:[player_id["id"].to_s]
        })
        render json: {
          result: "Notication was sended"
        }
      end
    end

  end
end

module Api
  module V1
    class HomeController < ApplicationController
      # before_action :authorize_request
      def index
        # all
        players = OneSignal::Player.all(params:{app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc"})
        player_id = JSON.parse(players.body)["players"][2]

        # notification = OneSignal::Notification.create(params:{
        #   app_id: "d5d9db25-332e-4f14-9dd2-1feec0fbf3cc",
        #   contents:{
        #     en:"Se eu tivesse passado vcs nao teria passado - Oliveira, Mateus"
        #
        #   },
        #   ios_category:"PARKING_INVITATION",
        #   buttons:[{id:"1",text:"Acept",icon:"some"},{id:"2",text:"Reject",icon:"some"}],
        #   include_player_ids:[player_id["id"].to_s],
        #   action: "like-btn",
        #   content_available:true,
        #   data:{
        #     name: "Alcides",
        #     idade: 25
        #   }
        # })
        render json: {
          result: "Notication was sended #{player_id['id']}"
        }
      end
    end

  end
end

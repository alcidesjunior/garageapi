class Notifications

  def initialize(app_id,user_auth_key,api_key)
    OneSignal::OneSignal.user_auth_key = user_auth_key
    OneSignal::OneSignal.api_key = api_key
    self.app_id = app_id
  end

  def toGarage(user_id)
    _user = User.find_by(user_id)

    notification = OneSignal::Notification.create(params:{
      app_id: self.app_id,
      contents:{
        en:"#{_user.name} deseja estacionar na sua garagem.\nDeseja permitir?"
      },
      ios_category:"PARKING_INVITATION",
      buttons:[{id:"1",text:"Acept",icon:"some"},{id:"2",text:"Reject",icon:"some"}],
      include_player_ids:[player_id["id"].to_s],
      action: "like-btn",
      content_available:true,
      data:{
      }
    })
    # render json: {
    #   result: "Notication was sended #{player_id['id']}"
    # }
  end
end

class Notifications

  def initialize(app_id,user_auth_key,api_key)
    OneSignal::OneSignal.user_auth_key = user_auth_key
    OneSignal::OneSignal.api_key = api_key
    @app_id = app_id
  end

  def toGarage(garage_owner_id,driver_id)
    _driver = User.find_by_id(driver_id)
    _garager = User.find_by_id(garage_owner_id)
    puts "[#{_driver.player_id}] o proprietário do carro #{_driver.vehicle.model} de placa #{_driver.vehicle.license_plate} deseja estacionar na sua garagem.\nDeseja permitir?"
    notification = OneSignal::Notification.create(params:{
      app_id: @app_id,
      contents:{
        en:"O proprietário do carro #{_driver.vehicle.model} de placa #{_driver.vehicle.license_plate} deseja estacionar na sua garagem.\nDeseja permitir?"
      },
      ios_category:"PARKING_INVITATION",
      buttons:[{id:"1",text:"Acept",icon:"some"},{id:"2",text:"Reject",icon:"some"}],
      include_player_ids:[_garager.player_id],
      action: "like-btn",
      content_available:true,
      data:{}
    })
  end

  def toDriver(user_id, message)
    _user = User.find_by_id(user_id)

    notification = OneSignal::Notification.create(params:{
      app_id: @app_id,
      contents:{
        en:"#{message}"
      },
      ios_category:"PARKING_INVITATION",
      buttons:[{id:"1",text:"Acept",icon:"some"},{id:"2",text:"Reject",icon:"some"}],
      include_player_ids:[_user.player_id],
      action: "like-btn",
      content_available:true,
      data:{}
    })
  end
end

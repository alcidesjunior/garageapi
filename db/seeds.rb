require 'faker'
#user
# user_params = {name:"JP", email: "jp@apple.com",document_type: "cpf",
#   document_number: "123.312.313-22", password: "12345678", role: "ROLE_GD"}
# user = User.new(user_params)
# if user.save
#   puts "USER created!"
#   # #address
#   add_params = {zip: "2222222", street: "Rua das casas", number: "12",
#   complement: "s/n", city: "Fantasma", uf: "Ce", user_id: user.id}
#   address = Address.new(add_params)
#   if address.save
#     puts "Address created!"
#     #first garage
#     garage_params = {description: "Minha garagem", parking_spaces: 1,
#       price: 12.00, photo1: "o.jpg", photo2: "a.jpg", photo3: "z.jpg",
#       :user_id=> user.id}
#     garage = Garage.new(garage_params)
#     garage.save
#
#     address.garage_id = garage.id
#     address.save
#
#     #second garage
#
#
#     localcoment = {:from_user_id=>1,:to_user_id=>1,:garage_id=>garage.id,:title=>"Best Host",:message=>"I had a best experience with this garage. Really good!",:rating=>4 }
#     comment = Comment.new(localcoment)
#
#     cmt = {:from_user_id=>1,:to_user_id=>1,:garage_id=>1,:title=>"Really bad :/",:message=>"I dont like...bad service...",:rating=>1 }
#     cmt = {:from_user_id=>1,:to_user_id=>1,:garage_id=>1,:title=>"I like of the service",:message=>"I dont like...bad service...",:rating=>2 }
#     if comment.save
#       puts "Comment was added"
#     end
#   else
#     puts "Address Error => #{address.errors.full_messages}"
#   end
#
#
#
#   add_params = {zip: "2222222", street: "Rua das casas", number: "12",
#   complement: "s/n", city: "Fantasma", uf: "Ce", user_id: nil}
#   address = Address.new(add_params)
#   if address.save
#     puts "Address created!"
#     #first garage
#     garage_params = {description: "Garagem 02", parking_spaces: 1,
#       price: 15.00, photo1: "1.jpg", photo2: "2.jpg", photo3: "3.jpg",
#       :user_id=> user.id}
#     garage = Garage.new(garage_params)
#     garage.save
#
#     address.garage_id = garage.id
#     address.save
#
#     mock_veh = {model: "Honda Civic", chassi: "127836123AS87", license_plate: "hvu-2020", year: 2010, driver_license: "1238338383VU",user_id: 1}
#     veh = Vehicle.new(mock_veh)
#     if veh.save
#       puts "Vehicle was created!"
#       parking = {garage_owner_id: 1, driver_id: 1, price: 0.0, license_plate: "huv-2020",garage_id: garage.id, vehicle_id: veh.id, start: DateTime.now}
#       park = Parking.new(parking)
#       if park.save
#         garage = Garage.find(garage.id)
#         garage.busy_space = (garage.busy_space) + 1
#         garage.save
#         puts "Parking was created!"
#       else
#         puts "Error when try add Parking"
#         puts "#{park.errors.full_messages}"
#       end
#     else
#       puts "Error when try add vehicle"
#       puts "#{veh.errors.full_messages}"
#     end
#
#     #second garage
#
#     localcoment = {:from_user_id=>1,:to_user_id=>1,:garage_id=>garage.id,:title=>"Crazy",:message=>"nunca mais que eu volto.",:rating=>2 }
#     comment = Comment.new(localcoment)
#
#     cmt = {:from_user_id=>1,:to_user_id=>1,:garage_id=>1,:title=>"Really bad :/",:message=>"I dont like...bad service...",:rating=>1 }
#     if comment.save
#       puts "Comment was added"
#     end
#   else
#     puts "Address Error => #{address.errors.full_messages}"
#   end
# else
#   puts "Error => #{user.errors.full_messages}"
# end

def users(qtd = 2)
  #creating users
  qtd.Times do |n|
    user_params = {name: Faker::Name.name, email: Faker::Internet.email,document_type:'cpf', document_number: "222.145.#{n}23.980-98", password: '12345678', role: ''}
    unless n%2==0
      user_params.role = 'ROLE_GD'
    else
      user_params.role = 'ROLE_GO'
    end
    user = User.new(user_params)
    begin
      user.save
      puts "Usuario inserido"
    rescue
      puts "Erro ao inserir usuario"
    end
  end
end
def address(qtd = 2)
  add_params = {zip:  Faker::Address.zip_code, street: Faker::Address.street_name, number: Faker::Address.building_number, complement: Faker::Address.community, city: Faker::Address.city, uf: Faker::Address.state_abbr, lat: Faker::Address.latitude,long: Faker::Address.longitude}
  qtd.Times do |n|
    adr = Address.new(add_params)
    begin
      adr.save
      puts "Endereço inserido"
    rescue
    end
  end
end

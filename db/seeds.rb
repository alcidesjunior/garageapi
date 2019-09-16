# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#user
user_params = {name:"JP", email: "jp@apple.com",document_type: "cpf",
  document_number: "123.312.313-22", password: "12345678", role: "user"}
user = User.new(user_params)
if user.save
  puts "USER created!"
  # #address
  add_params = {zip: "2222222", street: "Rua das casas", number: "12",
  complement: "s/n", city: "Fantasma", uf: "Ce", user_id: user.id}
  address = Address.new(add_params)
  if address.save
    puts "Address created!"
    # #garage
    garage_params = {description: "Minha garagem", parking_spaces: 1,
      price: 12.00, photo1: "o.jpg", photo2: "a.jpg", photo3: "z.jpg",
      :user_id=> user.id}
    garage = Garage.new(garage_params)
    garage.save

    address.garage_id = garage.id
    address.save
  else
    puts "Address Error => #{address.errors.full_messages}"
  end
else
  puts "Error => #{user.errors.full_messages}"
end

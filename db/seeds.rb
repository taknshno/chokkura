Faker::Config.locale = :en

### User ###
5.times do |n|
  first_name = Faker::Name.unique.first_name
  last_name = Faker::Name.unique.last_name
  password = "password"
  location = User.locations.keys.sample
  admin = Faker::Boolean.boolean

  User.create!( name: "#{first_name} #{last_name}",
                email: "#{last_name.downcase}@example.com",
                password: password,
                password_confirmation: password,
                location: location,
                admin: admin
               )
end

puts "User Data ...ok"


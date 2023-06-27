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


### Tag ###

Tag.create!( name: "グルメ" )
Tag.create!( name: "自然" )
Tag.create!( name: "映えスポット" )
Tag.create!( name: "お土産" )
Tag.create!( name: "体験型" )
Tag.create!( name: "歴史" )
Tag.create!( name: "パワースポット" )

puts "Tag Data ...ok"


### Spot ###

User.create!( name: "鹿島神宮",
  #images: ,
  area: ,
  address:,
  phone:,
  holiday:,
  sales_copy:,
  detail_description:,
  simple_description:
 )
# Tag.create!( name: "自然" )
# Tag.create!( name: "映えスポット" )
# Tag.create!( name: "お土産" )
# Tag.create!( name: "体験型" )
# Tag.create!( name: "歴史" )
# Tag.create!( name: "パワースポット" )

#puts "Spot Data ...ok"
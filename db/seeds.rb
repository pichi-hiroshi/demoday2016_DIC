# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#$ rake db:seed　で実行できる
10.times do |n|
  email = Faker::Internet.email
  password = "password"
  userid = Random.new.rand(1..10000)
  name = Faker::Internet.user_name
  affiliation = Faker::Company.name
  discription = Faker::Name.title
  image_url = Faker::Avatar.image
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               uid: userid,
               name: name,
               affiliation: affiliation,
               discription: discription,
               image_url: image_url
               )
end
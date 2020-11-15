require 'faker'
require "open-uri"
require 'date'

#Destroy all current users when running this seed
User.destroy_all

#Adding Batman as first User
first = User.create(email: "b@t.man", username: "batman", password:'123456')
file = URI.open('https://www.pngkit.com/png/detail/6-61591_batman-icon-jira-avatar.png')
first.photo.attach(io: file, filename: 'bat.png', content_type: 'image/png')
first.about = "I am Batman!!!"
first.save!

#Adding some Users to the DB
10.times do
  about = ""
  10.times do
    about += "#{Faker::Movies::Hobbit.quote} "
  end
  user = User.create(email: Faker::Internet.email, username: Faker::Movies::LordOfTheRings.character, password:'123456')
  coin = rand(2)+1
  if coin == 1
    file = URI.open("https://randomuser.me/api/portraits/women/#{rand(99)}.jpg")
  else
    file = URI.open("https://randomuser.me/api/portraits/men/#{rand(99)}.jpg")
  end
  user.about = about
  user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/jpg')
  user.save!
end

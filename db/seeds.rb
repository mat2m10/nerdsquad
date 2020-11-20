require 'faker'
require "open-uri"
require 'date'

#Destroy all current users when running this seed
User.destroy_all

#Adding Batman as first User
first = User.create(email: "b@t.man", username: "batman", password:'123456')

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Topic.destroy_all
Insight.destroy_all

user = User.create(email: 'myemail@gmail.com', password: 'password')
puts 'User Created'
the_internet = Topic.create(name: 'The Internet', user: user)
puts "Topic: #{the_internet.name} created"
just_computers = Insight.create(topic: the_internet, text: "It's just a bunch of computers")
puts "Insight: #{just_computers.text} created for topic: #{just_computers.topic.name}"

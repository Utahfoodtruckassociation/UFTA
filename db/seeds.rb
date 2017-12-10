# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.find_or_create_by(
# 	email: "truck@gmail.com",
# 	password: "asdfasdf",
# 	password_confirmation: "asdfasdf",
# 	name: "Truck User",
# 	roles: "truck"
# )
# User.find_or_create_by(
# 	email: "thiep@thiepseats.com",
# 	password: "asdfasdf",
# 	password_confirmation: "asdfasdf",
# 	name: "Truck User 1",
# 	roles: "truck"
# )

# puts "2 Truck user created"

User.find_or_create_by(
	email: "admin@ufta.com",
	password: "asdfasdf",
	password_confirmation: "asdfasdf",
	name: "Admin User",
	roles: "admin"
)

puts "1 Admin user created"

# 3.times do |truck|
# 	Truck.create!(
# 		truck_name: "Art City Donuts: #{truck}",
# 		description: "Now that we've seen Procs and Lambdas I think it's important to clarify the difference between the two. There are two key differences in addition to the syntax. Please note that the differences are subtle, even to the point that you may never even notice them while programming. Still, they're good to know, especially if you plan on building advanced programs.",
# 		main_image: "http://via.placeholder.com/600x400",
# 		thumb_image: "http://via.placeholder.com/350x200",
# 		food_type: "Desserts",
# 		time_zone: "America/Denver",
# 		user_id: "#{truck + 1}"
# 	)
# end

# puts "3 trucks created"

# Truck.all.each do |truck|
# 	(rand(4) + 1).times do |menu|
# 		truck.menus.create!(
# 			title: "French Toast Donuts #{menu}",
# 			description: "Now that we've seen Procs and Lambdas I think it's important to clarify the difference between the two. There are two key differences in addition to the syntax. Please note that the differences are subtle,",
# 			food_image: "http://via.placeholder.com/350x200",
# 			price: "7.99"
# 		)
# 	end
# end

# puts "1 to 5 Menu Items created for each truck"


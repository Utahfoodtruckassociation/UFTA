# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
	email: "sample@gmail.com",
	password: "asdfasdf",
	password_confirmation: "asdfasdf",
	name: "Regular User"
)

puts "1 Regular user created"

User.create!(
	email: "Admin@gmail.com",
	password: "asdfasdf",
	password_confirmation: "asdfasdf",
	name: "Admin User"
)

puts "1 Admin user created"

3.times do |truck|
	Truck.create!(
		truck_name: "Art City Donuts: #{truck}",
		description: "Now that we've seen Procs and Lambdas I think it's important to clarify the difference between the two. There are two key differences in addition to the syntax. Please note that the differences are subtle, even to the point that you may never even notice them while programming. Still, they're good to know, especially if you plan on building advanced programs.",
		main_image: "https://s3.amazonaws.com/dj-food-truck/uploads/truck/main_image/2/donutss.jpg",
		thumb_image: "https://s3.amazonaws.com/dj-food-truck/uploads/truck/thumb_image/2/donut.jpg"
	)
end

puts "3 trucks created"

3.times do |menu|
	Truck.first.menus.create!(
		title: "French Toast Donuts #{menu}",
		description: "Now that we've seen Procs and Lambdas I think it's important to clarify the difference between the two. There are two key differences in addition to the syntax. Please note that the differences are subtle,",
		food_image: "https://s3.amazonaws.com/dj-food-truck/uploads/menu/food_image/4/cookies.jpg",
		price: "7.99"
	)
end

puts "3 Menu Items created"


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Cleaning the database... '
User.destroy_all
Notification.destroy_all
Assignment.destroy_all

user = User.create! email: 'anne@gmail.com', password: 'topsecret', password_confirmation: 'topsecret'
userTwo = User.create! email: 'julia@gmail.com', password: 'topsecret', password_confirmation: 'topsecret'
p '-----------------------------------------------------------'
p 'Created these users 🙎🏽‍♀️ 🙍‍♂️ -->'
p User.all

users_array = User.all

notifications = [
  { date: DateTime.now, title: 'First notification', description: 'This is the first notification' },
  { date: DateTime.now, title: 'Second notification', description: 'This is the second notification' },
  { date: DateTime.now, title: 'Third notification', description: 'This is the third notification' }
]

notifications.each do |notification|
  new_notification = Notification.new(notification)
  new_notification.save!
end
Notification.new({ "title": 'Marks test' }).save!
p '-----------------------------------------------------------'
p 'Created these notifications 📢 -->'
p Notification.all

assignments = [
  { notification_id: Notification.first.id, user_id: User.first.id },
  { notification_id: Notification.second.id, user_id: User.first.id },
  { notification_id: Notification.second.id, user_id: User.second.id }
]

assignments.each do |assignment|
  new_assignment = Assignment.new(assignment)
  new_assignment.save!
end
p '-----------------------------------------------------------'
p 'Created these assignments that assigned notifications to users 📝 -->'
p Notification.all

p '-----------------------------------------------------------'
p '🏁 finished seeding 🏁'

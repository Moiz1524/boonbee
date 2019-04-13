# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: 'Moiz Ali', first_name: 'Moiz', last_name: 'Ali', email: "moiz@example.com", password: "abc123", admin: true)
User.create(first_name: 'User', email: "user@test.com",password: "admin123")

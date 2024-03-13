# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(
  name: "Example User",
  email: "example@railstutorial.org",
  birthday: "2002-01-13",
  gender: "male",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true
)

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  birthday = Faker::Date.birthday(min_age: 18, max_age: 100)
  gender = %w[male female other].sample
  password = "password"
  User.create!(
    name:,
    email:,
    birthday:,
    gender:,
    password:,
    password_confirmation: password
  )
end

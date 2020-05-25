# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
50.times do
  User.create!( username: Faker::Internet.username,
                firstname: Faker::Name.first_name,
                lastname: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: 'qwerty'
  )
end

@users = User.all

5.times do
  Theme.create!(name: Faker::Lorem.question)
end

@themes = Theme.all

@themes.each do |theme|
  5.times do
    theme.questions.create!( title: Faker::Lorem.question,
                             documentation: Faker::Lorem.paragraphs,
                             start_time: "2020-05-23 16:15:40",
                             end_time: "2020-05-23 17:15:40"
    )
  end
end
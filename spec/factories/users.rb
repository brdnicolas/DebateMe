FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'foobar' }
    isPremium { Faker::Number.between(from: 0, to: 1) }
    isBan { 0 }

  end
end
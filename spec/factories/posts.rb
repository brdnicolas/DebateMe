FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraphs }
    isAnonym { Faker::Number.between(from: 0, to: 1)}
    up { Faker::Number.between(from: 0, to: 10000)}
    down { Faker::Number.between(from: 0, to: 10000)}
    user_id { nil }
  end
end
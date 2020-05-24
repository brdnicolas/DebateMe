FactoryBot.define do
  factory :theme do
    name { Faker::Lorem.question }
  end
end

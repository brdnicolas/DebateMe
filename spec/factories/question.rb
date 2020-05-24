FactoryBot.define do
  factory :question do
    title { Faker::Lorem.questions }
    documentation { Faker::Lorem.paragraphs }
    start_time { "2020-05-23 16:15:40" }
    end_time { "2020-05-23 17:15:40"}
  end
end
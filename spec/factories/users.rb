FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    seniority { Faker::Job.seniority }
    email { Faker::Internet.email }
    city
  end
end

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(3) }
    description { Faker::Lorem.sentence(30, false, 10) }
    author { create(:user) }
  end
end

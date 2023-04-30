FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 3) }

    description { Faker::Lorem.sentence(
      word_count: 30, random_words_to_add: 10
    ) }

    author { create(:user) }
  end
end

FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(
      word_count: 30, random_words_to_add: 10
    ) }

    author { create(:user) }
    post { create(:post) }

    trait :invalid do
      body { nil }
    end
  end
end

FactoryBot.define do
  factory :book do
    factory :valid_book do
      name { Faker::Book.title }
      description { Faker::Lorem.paragraph_by_chars(number: 300, supplemental: false) }
      author { Faker::Book.author }
      user_id { User.last.id }
    end
  end
end

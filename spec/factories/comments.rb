# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    factory :valid_comment do
      commenter { User.last.name }
      comment do Faker::Lorem.paragraph_by_chars(number: 100,
                                                 supplemental: false)
      end
      book_id { Book.last.id }
      user_id { User.last.id }
    end
  end
end

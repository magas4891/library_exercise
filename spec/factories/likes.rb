# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    factory :valid_like do
      book_id { Book.last.id }
      user_id { User.last.id }
    end
  end
end

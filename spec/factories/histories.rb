FactoryBot.define do
  factory :history do
    factory :valid_history do
      book_id { Book.last.id }
      user_id { User.last.id }
      name { User.last.name }
      take_date { Time.now }
    end
  end
end

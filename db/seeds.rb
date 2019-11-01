# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Book.create(name: Faker::Book.title,
              cover: Faker::Avatar.image,
              description: Faker::Lorem.paragraph,
              likes_counter: Faker::Number.within(range: 1..10),
              author: Faker::Book.author,
              comment: Faker::ChuckNorris.fact)
end

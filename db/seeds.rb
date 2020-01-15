# frozen_string_literal: true

User.create(email: 'user1@gmail.com', password: 'password', name: 'admin1')
User.create(email: 'user2@gmail.com', password: 'password', name: 'admin2')
10.times do
  User.create!(email: Faker::Internet.email,
               password: Faker::Internet.password,
               name: Faker::Name.name)
  p User.last.name
end
20.times do
  Book.create!(name: Faker::Book.title,
               description:
                   Faker::Lorem.paragraph_by_chars(number: 300,
                                                   supplemental: false),
               likes_counter: Faker::Number.within(range: 1..50),
               taken: Faker::Number.within(range: 1..10),
               author: Faker::Book.author,
               user_id: User.first.id)
  p Book.last.name
end

Dir.chdir("#{Rails.root}/public/uploads/book/cover/")
images_path = Dir['*.*']
Book.all.zip(images_path).each do |book, image|
  book.cover = open(image)
  book.save
  p "Cover fo #{book.name} added!"
end

100.times do
  book = Book.all.sample
  user = User.all.sample
  History.create!(book_id: book.id,
                  user_id: user.id,
                  name: user.name,
                  take_date: Time.now,
                  return_date: Time.now || nil)
  p "#{History.last.book.name} #{History.last.name}"
end

200.times do
  book = Book.all.sample
  user = User.all.sample
  Comment.create!(book_id: book.id,
                  user_id: user.id,
                  commenter: user.name,
                  comment: Faker::Lorem.paragraph)
  p "#{Comment.last.commenter} #{Comment.last.comment}"
end

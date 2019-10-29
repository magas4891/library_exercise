class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: Text
  field :like_counter, type: Integer
  field :author, type: String
end

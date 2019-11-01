class Reader
  include Mongoid::Document
  include Mongoid::Timestamps
  field :book_id, type: String
  field :user_id, type: String

  belongs_to :user
  belongs_to :book
end

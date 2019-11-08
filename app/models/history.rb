class History
  include Mongoid::Document
  include Mongoid::Timestamps

  field :book_id, type: String
  field :user_id, type: Object
  field :name, type: String
  field :take_date, type: Date
  field :return_date, type: Date, default: -> { nil }

  belongs_to :book
  belongs_to :user

end

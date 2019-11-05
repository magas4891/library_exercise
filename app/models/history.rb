class History
  include Mongoid::Document
  include Mongoid::Timestamps

  field :book_id, type: String
  field :name, type: String
  field :take_date, type: Date
  field :return_date, type: Date, default: -> { nil }

  belongs_to :book

end

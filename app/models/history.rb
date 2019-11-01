class History
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :book_id, type: String
  field :take_date, type: String
  field :return_date, type: String
end

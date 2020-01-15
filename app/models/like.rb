# frozen_string_literal: true

class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  field :book_id, type: Object
  field :user_id, type: Object

  belongs_to :book
  belongs_to :user
end

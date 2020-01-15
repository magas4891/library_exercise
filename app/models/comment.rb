# frozen_string_literal: true

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :commenter, type: String
  field :comment, type: String
  field :book_id, type: String
  field :user_id, type: String

  belongs_to :user
  belongs_to :book

  validates :comment, presence: true
end

class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :cover, type: String
  field :description, type: String
  field :likes_counter, type: Integer, default: -> { 0 }
  field :author, type: String
  field :comment, type: String
  field :status, type: Boolean, default: -> { true }
  field :user_id, type: Object, default: -> { 0 }
  field :taken, type: Integer, default: -> { 0 }

  mount_uploader :cover, CoverUploader
  belongs_to :user
  has_many :comments
  has_many :histories
end

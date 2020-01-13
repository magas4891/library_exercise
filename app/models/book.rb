class Book
  include Mongoid::Document
  include Mongoid::Search
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
  field :rank, type: Integer, default: -> { 0 }

  mount_uploader :cover, CoverUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :likes

  validates :name, :description, :author, presence: true

  search_in :name, :description, :author

end

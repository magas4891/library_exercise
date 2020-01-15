# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_book, :already_liked?

  def create
    @book.likes.create!(user_id: current_user.id, book_id: @book.id)
    @book.inc(likes_counter: 1)
  end

  private

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_like
    @like = @book.likes.where(user_id: current_user.id).first
  end

  def already_liked?
    Like.where(user_id: current_user.id,
               book_id: params[:book_id]).exists?
  end
end

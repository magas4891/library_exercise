# frozen_string_literal: true

class ReadersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_book
  before_action :find_like, only: [:destroy]

  def take
    unless already_taken?
      @book.status = false
      @book.user_id = current_iser.id
      Reader.create(user_id: current_user.id, book_id: @book.id)
    end
    redirect_to book_path(@book)
  end

  def return
    @book.status = true
    redirect_to book_path(@book)
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end

  def find_like
    # @take = @book.likes.where(user_id: current_user.id).first
  end

  def already_taken?
    Reader.where(book_id: params[:id]).exists?
  end
end

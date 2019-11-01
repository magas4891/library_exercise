# frozen_string_literal: true

class ReadersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_book
  before_action :find_reader, only: [:destroy]

  def create
    unless already_taken?
      @book.update(status: false)
      @book.user_id = current_user.id
      Reader.create(user_id: current_user.id, book_id: @book.id)
      redirect_to book_path(@book)
    end
  end

  def destroy
    @reader.destroy
    @book.update(status: true)
    redirect_to book_path(@book)
  end

  private

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_reader
    @reader = Reader.where(user_id: current_user.id, book_id: @book.id)
  end

  def already_taken?
    Reader.where(book_id: params[:book_id]).exists?
  end
end

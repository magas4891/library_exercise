# frozen_string_literal: true

class ReadersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_book
  # before_action :create_history, only: [:create]
  before_action :find_reader, only: [:destroy]
  before_action :update_history, only: [:destroy]

  def create
    # unless already_taken?
    #   @book.update(status: false)
    #   @book.user_id = current_user.id
    #   Reader.create(user_id: current_user.id, book_id: @book.id)
    #   @book.inc(taken: 1)
    #   redirect_to book_path(@book)
    # end
    @reader = Reader.new(reader_params)
    @reader.user_id = current_user.id
    @reader.book_id = @book.id
    @reader.save!
    # Reader.create(user_id: current_user.id, book_id: @book.id)
  end

  def destroy
    @reader.destroy
    # @book.update(status: true)
    redirect_to book_path(@book)
  end

  private

  def reader_params
    params.require(:reader).permit(:user_id, :book_id)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_reader
    @reader = Reader.where(user_id: current_user.id, book_id: @book.id)
  end

  def already_taken?
    Reader.where(book_id: params[:book_id]).exists?
  end

  def create_history
    History.create(name: current_user.name, book_id: @book.id, take_date: Time.now)
  end

  def update_history
    @history = History.where(user_id: current_user.id, book_id: @book.id,
                             return_date: nil)
    @history.update(return_date: Time.now)
  end
end

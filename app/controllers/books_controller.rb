# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy take return]
  before_action :set_history, only: [:return]
  before_action :already_liked, only: [:show]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @comments = Comment.where(book_id: @book).order('created_at DESC')
    @histories = @book.histories
    @like_owner = true if already_liked
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit; end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def take
    @book.inc(taken: 1)
    @book.update(user_id: current_user.id, status: false)
    @book.histories.create!(user_id: current_user.id, name: current_user.name,
                            take_date: Time.now)
    redirect_to @book
  end

  def return
    @history.update(return_date: Time.now)
    @book.update(user_id: User.first.id, status: true)
    redirect_to @book
  end

  def rating
    # @book.rating =
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :description, :author, :cover)
  end

  def set_history
    @history = @book.histories.where(name: current_user.name, book_id: @book.id,
                                     return_date: nil )
  end

  def already_liked
    Like.where(user_id: current_user.id,
               book_id: params[:id]).exists?
  end
end

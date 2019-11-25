# frozen_string_literal: true

class CommentsController < ApplicationController

  def index
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(comments_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.commenter = current_user.name
    if @comment.save
      redirect_to book_path(@book)
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:commenter, :comment, :user_id, :book_id)
  end
end

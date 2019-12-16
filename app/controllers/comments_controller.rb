# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
  end

  def create
    @book = Book.find(params[:book_id])
    @comments = Comment.where(book_id: @book.id)
    @comment = @book.comments.new(comments_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.commenter = current_user.name
    @comment.save!
    respond_to do |format|
      if @comment.save
        format.js
      end
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:commenter, :comment, :user_id, :book_id)
  end
end

# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    # @comments = Comment.all.order('created_at DESC')
    # user_activity('showing_index_comments') if current_user
  end

  def create
    @book = Book.find(params[:id])
    @comment = @book.comments.new(comments_params)
    @comment.user = current_user
    @comment.commenter =
        current_user.nick? ? current_user.nick : current_user.name
    if @comment.save
      redirect_to book_path(@book)
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:commenter, :text, :user_id, :book_id)
  end
end

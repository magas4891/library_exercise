# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @comments = Comment.all.order('created_at DESC')
    user_activity('showing_index_comments') if current_user
  end

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comments_params)
    @comment.user = current_user
    @comment.commenter =
        current_user.nick? ? current_user.nick : current_user.name
    if @comment.save
      user_activity('comment') if current_user
      redirect_to image_path(@image)
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:commenter, :text, :user_id, :image_id)
  end
end

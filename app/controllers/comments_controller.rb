# frozen_string_literal: true

class CommentsController < ApplicationController
  protect_from_forgery except: %i[create]
  before_action :authenticate_user!

  def show
    reviews = Review.find(params[:id])
    comments = reviews.comments&.array_with_user
    comments.each do |comment|
      comment['user']['icon'] = icon_url(User.find(comment['user']['id']))
    end
    render json: { comments: comments }
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: { status: :success, comment: comment }
    else
      render json: { status: :error, message: comment.errors.full_messages }
    end
  end

  private

  def comment_params
    params[:comments][:user_id] = current_user.id
    params.require(:comments).permit(:review_id, :user_id, :comment)
  end
end

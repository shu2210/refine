# frozen_string_literal: true

class CommentsController < ApplicationController
  protect_from_forgery except: %i[create update destroy]
  before_action :authenticate_user!, except: %i[show]

  def show
    reviews = Review.find(params[:id])
    comments = reviews.comments&.array_with_one(:user)
    render json: { comments: comments }
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: { status: :success, comment: comment.array_with_one(:user) }
    else
      render json: { status: :error, message: comment.errors.full_messages }
    end
  end

  def update
    comment = Comment.find(params[:id])
    if current_user != comment.user
      render json: { status: :error }
    else
      comment.update!(comment: params[:comment])
      render json: { status: :success, comment: comment }
    end
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render json: { status: :success, comment: comment }
    else
      render json: { status: :error, message: comment.errors.full_messages }
    end
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  private

  def comment_params
    params[:comments][:user_id] = current_user.id
    params.require(:comments).permit(:review_id, :user_id, :comment)
  end
end

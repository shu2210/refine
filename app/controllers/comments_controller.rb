# frozen_string_literal: true

class CommentsController < ApplicationController
  protect_from_forgery except: %i[create]
  before_action :authenticate_user!

  def index
    comments = Comment.all.order(:created_at)
    render json: { comments: comments }
  end

  def show
    reviews = Review.find(params[:id])
    render json: { comments: reviews&.comments&.order(:created_at) }
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

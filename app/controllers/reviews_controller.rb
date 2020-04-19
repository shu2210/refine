# frozen_string_literal: true

class ReviewsController < ApplicationController
  protect_from_forgery except: %i[create update destroy]
  before_action :authenticate_user!, except: %i[show]

  def show
    reviews = Review.includes(:user).where(code_id: params[:id]).order(:created_at)
    render json: { review: reviews.array_with(:comments, :user) }
  end

  def create
    review = Review.new(review_params)
    review.user = current_user
    if review.save
      render json: { status: :success, review: review.array_with(:user) }
    else
      render json: { status: :error, message: review.errors.full_messages }
    end
  end

  def update
    review = Review.find(params[:id])
    if current_user != review.user
      render json: { status: :error }
    else
      review.update!(review: params[:review])
      render json: { status: :success, review: review }
    end
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  def destroy
    review = Review.find(params[:id])
    if current_user != review.user
      render json: { status: :error }
    elsif review.destroy
      render json: { status: :success, comments: review.comments.with_deleted }
    end
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  private

  def review_params
    params.require(:review).permit(:code_id, :line, :review)
  end
end

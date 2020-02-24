# frozen_string_literal: true

class ReviewsController < ApplicationController
  protect_from_forgery except: %i[create destroy]
  before_action :authenticate_user!, except: %i[show]

  def show
    reviews = Review.where(code_id: params[:id])
    users = reviews.map(&:user)
    render json: { review: reviews, users: users }
  end

  def create
    review = Review.new(review_params)
    review.user = current_user
    if review.save
      render json: { status: :success, user: review.user, icon: icon_url(review.user) }
    else
      render json: { status: :error, message: review.errors.full_messages }
    end
  end

  def destroy
    review = Review.find(params[:id])
    if current_user != review.user
      render json: { status: :error }
    elsif review.destroy
      render json: { status: :success }
    end
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  private

  def review_params
    params.require(:review).permit(:code_id, :line, :review)
  end

  def icon_url(user)
    return unless user.icon&.attached?

    url_for(user.icon)
  end
end

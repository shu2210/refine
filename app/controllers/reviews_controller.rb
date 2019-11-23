# frozen_string_literal: true

class ReviewsController < ApplicationController
  protect_from_forgery except: %i[create destroy]
  before_action :authenticate_user!

  def create
    review = Review.new(review_params)
    review.user = current_user
    if review.save
      render json: { status: :success }
    else
      render json: { status: :error, message: review.errors.full_messages }
    end
  end

  private

  def review_params
    params.require(:review).permit(:code_id, :line, :review)
  end
end
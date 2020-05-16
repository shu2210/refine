# frozen_string_literal: true

class Reviews::ResolutionsController < ApplicationController
  protect_from_forgery except: %i[update]
  before_action :authenticate_user!

  def update
    review = Review.find(params[:id])
    if current_user != review.user
      render json: { status: :error }
    else
      review.update!(resolved: params[:resolve])
      render json: { status: :success, review: review }
    end
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end
end

# frozen_string_literal: true

class Comments::ResolutionsController < ApplicationController
  before_action :authenticate_user!

  def update
    comment = Comment.find(params[:id])
    if current_user != comment.user
      render json: { status: :error }
    else
      comment.update!(resolved: true)
      render json: { status: :success, comment: comment }
    end
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end
end

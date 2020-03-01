# frozen_string_literal: true

class Codes::LikesController < ApplicationController
  protect_from_forgery except: %i[create destroy]
  before_action :authenticate_user!

  def create
    code = UserCode.find(params[:code_id])
    like = UserCodeLike.new(user: current_user, user_code: code)
    like.save!
    render json: { status: :success }
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  def destroy
    like = UserCodeLike.find_by(user_code_id: params[:id], user_id: current_user.id)
    like.destroy!
    render json: { status: :success }
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end
end

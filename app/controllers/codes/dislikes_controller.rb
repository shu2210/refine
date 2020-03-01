# frozen_string_literal: true

class Codes::DislikesController < ApplicationController
  protect_from_forgery except: %i[create destroy]
  before_action :authenticate_user!

  def create
    code = UserCode.find(params[:code_id])
    like = UserCodeDislike.new(user: current_user, user_code: code)
    like.save!
    render json: { status: :success }
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  def destroy
    dislike = UserCodeDislike.find_by(user_code_id: params[:id], user_id: current_user.id)
    dislike.destroy!
    render json: { status: :success }
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end
end

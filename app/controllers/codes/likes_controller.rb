# frozen_string_literal: true

class Codes::LikesController < ApplicationController
  protect_from_forgery except: %i[create destroy]
  before_action :authenticate_user!

  def create
    code = Code.find(params[:code_id])
    like = CodeLike.new(user: current_user, code: code)
    like.save!
    render json: { status: :success }
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end

  def destroy
    like = CodeLike.find_by(code_id: params[:id], user_id: current_user.id)
    like.destroy!
    render json: { status: :success }
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end
end

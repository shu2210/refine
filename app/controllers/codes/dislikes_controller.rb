# frozen_string_literal: true

class Codes::DislikesController < ApplicationController
  protect_from_forgery except: :create
  before_action :authenticate_user!

  def create
    code = Code.find(params[:code_id])
    like = CodeDislike.new(user: current_user, code: code)
    like.save!
    render json: { status: :success }
  rescue StandardError => e
    logger.error e
    render json: { status: :error }
  end
end

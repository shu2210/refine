# frozen_string_literal: true

class CodesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index; end

  def new
    @code = Code.new
  end

  def create
    @code = Code.new(code_params)
    if @code.post(current_user, params[:tags])
      redirect_to root_path, success: 'コードの投稿が完了しました'
    else
      flash[:alert] = '入力内容に誤りがあります'
      render :new
    end
  end

  def show; end

  private

  def code_params
    params.require(:code).permit(
      :title, :description, :language_id, :code
    )
  end
end

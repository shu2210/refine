# frozen_string_literal: true

class CodesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index; end

  def new
    @code = Code.new
  end

  def create
    @code = Code.new(code_params)
    if @code.save
      flash[:success] = 'コードの投稿が完了しました'
      redirect_to root_path
    else
      flash[:alert] = '入力内容に誤りがあります'
      render :new
    end
  end

  def show; end

  private

  def code_params
    params[:code][:user_id] = current_user.id
    params.require(:code).permit(
      :title, :description, :language_id, :user_id, :code
    )
  end
end

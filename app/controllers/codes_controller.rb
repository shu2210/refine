# frozen_string_literal: true

class CodesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @latest = UserCode.latest
    @popular = UserCode.popular
  end

  def new
    @code = UserCode.new
    @code.codes.push(Code.new)
    @tags = Tag.all.pluck(:name)
  end

  def create
    @code = UserCode.new(user_codes_params)
    @code.codes = codes
    if @code.post(params[:tags])
      redirect_to root_path, success: 'コードの投稿が完了しました'
    else
      flash.now[:alert] = '入力内容に誤りがあります'
      render :new
    end
  end

  def show
    @code = UserCode.includes(:codes, :user).find(params[:id])
  end

  private

  def user_codes_params
    params[:user_code][:user_id] = current_user.id
    params.require(:user_code).permit(
      :title, :description, :user_id
    )
  end

  def codes
    params[:code].each(&:permit!)
    params[:code].map do |code|
      code = Code.new(code)
      code.valid?
      code
    end
  end
end

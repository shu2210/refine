# frozen_string_literal: true

class Codes::DraftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @drafts = UserCode.includes(:codes, :tags).where(status: :draft).order(updated_at: :desc)
  end

  def create
    @code = UserCode.new(code_params)
    @code.codes = codes
    @code.user = current_user
    if @code.draft(params[:tags])
      redirect_to root_path
    else
      render 'codes/new'
    end
  end

  def edit
    @code = UserCode.includes(:codes).find(params[:id])
    raise Forbidden unless current_user == @code.user

    @code.codes.build if @code.codes.empty?
  end

  def update; end

  def destroy
    @code = UserCode.find(params[:id])
    if current_user != @code.user
      render :index
    elsif @code.destroy
      flash[:success] = t('deleted')
      redirect_to action: :index
    else
      flash.now[:alert] = t('errors.invalid')
      render :index
    end
  end

  private

  def code_params
    params.require(:user_code).permit(
      :title, :description
    )
  end

  # TODO: codes_controllerとの重複解消
  def codes
    params[:code].each(&:permit!)
    params[:code].map do |code|
      Code.new(code)
    end
  end
end

# frozen_string_literal: true

class Codes::DraftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @drafts = UserCode.includes(:codes, :tags).drafts(current_user.id)
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

  def update
    @code = UserCode.find(params[:id])
    raise Forbidden unless current_user == @code.user

    @code.assign_attributes(code_params)
    @code.codes = codes
    if @code.update_version(params[:tag], :draft)
      redirect_to action: :index
    else
      render 'codes/edit'
    end
  end

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

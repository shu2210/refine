# frozen_string_literal: true

class Codes::DraftsController < ApplicationController
  include CodePermittable

  before_action :authenticate_user!
  before_action :verify_valid_user, only: %i[update]

  def index
    @drafts = UserCode.includes(:codes, :tags).drafts(current_user.id)
  end

  def create
    @code = UserCode.new(user_codes_params)
    @code.codes = codes
    @code.user = current_user
    if @code.draft(params[:tags])
      redirect_to root_path
    else
      render 'codes/new'
    end
  end

  def update
    @code = UserCode.new(user_codes_params)
    @code.codes = codes
    if @code.update_version(params[:id], params[:tags], :draft)
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

  def user_codes_params
    params.require(:user_code).permit(
      :title, :description
    )
  end
end

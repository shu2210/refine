# frozen_string_literal: true

class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id]).decorate
  end

  def edit
    @user = User.find(params[:id]).decorate
  end

  def update
    @user = User.find(params[:id])
    if @user.update_profile(user_params)
      flash.now[:success] = t('saved')
    else
      flash.now[:alert] = t('errors.invalid')
    end
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :description, :email, :icon)
  end
end

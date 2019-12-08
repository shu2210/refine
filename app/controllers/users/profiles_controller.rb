# frozen_string_literal: true

class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_profile(user_params)
      flash.now[:success] = t('saved')
    else
      flash.now[:error] = t('errors.invalid')
    end
    render :edit
  end

  private

  def user_params
    params.require(:users).permit(:name, :description)
  end
end

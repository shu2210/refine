# frozen_string_literal: true

class Users::ChangePasswordsController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.find(params[:id])
    if @user.change_password(user_params)
      flash[:success] = t('saved')
    else
      flash[:alert] = t('errors.invalid')
    end
    render 'users/profiles/edit'
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :new_password, :new_password_confirmation)
  end
end

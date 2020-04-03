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
      redirect_to action: :index, success: '下書き保存が完了しました'
    else
      render 'codes/new'
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

# frozen_string_literal: true

class Codes::DraftsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    @code = UserCode.new(code_params)
    @code.codes = codes
    @code.user = current_user
    @code.draft
    redirect_to root_path, success: '下書き保存が完了しました'
  end

  private

  def code_params
    params.require(:user_code).permit(
      :title, :description
    )
  end

  def codes
    params[:code].each(&:permit!)
    params[:code].map do |code|
      Code.new(code)
    end
  end
end

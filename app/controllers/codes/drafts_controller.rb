# frozen_string_literal: true

class Codes::DraftsController < ApplicationController
  before_action :authenticate_user!

  def create
    @code = Code.new(code_params)
    @code.user = current_user
    @code.draft
    redirect_to root_path, success: '下書き保存が完了しました'
  end

  private

  def code_params
    params.require(:code).permit(
      :title, :description, :language_id, :code
    )
  end
end

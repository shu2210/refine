# frozen_string_literal: true

class Codes::DraftsController < ApplicationController
  before_action :authenticate_user!

  def create
    @code = Code.new(code_params)
    @code.draft_at = Time.now
    @code.save(validate: false)
    flash[:success] = '下書き保存が完了しました'
    render 'codes/new'
  end

  private

  def code_params
    params.require(:code).permit(
      :title, :description, :language_id, :code
    )
  end
end

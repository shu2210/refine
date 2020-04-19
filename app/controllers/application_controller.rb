# frozen_string_literal: true

require 'errors/forbidden'

class ApplicationController < ActionController::Base
  rescue_from Forbidden, with: :rescue403

  def verify_valid_user
    code = UserCode.find(params[:id])
    raise Forbidden unless current_user == code.user
  end

  private

  def rescue403
    render 'errors/forbidden', status: 403
  end
end

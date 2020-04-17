# frozen_string_literal: true

require 'errors/forbidden'

class ApplicationController < ActionController::Base
  # TODO: Forbiddenページ作成
  # rescue_from Forbidden
  def verify_valid_user
    code = UserCode.find(params[:id])
    raise Forbidden unless current_user == code.user
  end
end

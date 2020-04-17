# frozen_string_literal: true

require 'errors/forbidden'

class ApplicationController < ActionController::Base
  # TODO: Forbiddenページ作成
  # rescue_from Forbidden
  before_action :verify_valid_user, only: %i[update]

  def verify_valid_user
    code = UserCode.find(params[:id])
    raise Forbidden unless current_user == code.user
  end
end

# frozen_string_literal: true

class Codes::HistoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    # TODO: codeに変更
    @drafts = UserCode.includes(:codes, :tags).drafts(current_user.id)
  end
end

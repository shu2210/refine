# frozen_string_literal: true

class Codes::HistoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    # TODO: codeに変更
    @histories = UserCode.histories(params[:id])
  end
end

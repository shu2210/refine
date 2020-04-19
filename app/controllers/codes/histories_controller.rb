# frozen_string_literal: true

class Codes::HistoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @histories = UserCode.histories(params[:id])
  end
end

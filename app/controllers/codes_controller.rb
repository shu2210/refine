# frozen_string_literal: true

class CodesController < ApplicationController
  def index; end

  def new
    @languages = Language.all
  end

  def show; end
end

# frozen_string_literal: true

class Users::FollowTagsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tags = Tag.all.pluck(:name)
  end

  def create
    render :new
  end
end

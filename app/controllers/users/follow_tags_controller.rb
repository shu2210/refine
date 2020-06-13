# frozen_string_literal: true

class Users::FollowTagsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tags = Tag.all.pluck(:name)
  end

  def create
    params[:tags].each do |tag|
      current_user.tags.create(name: tag)
    end
    redirect_to root_path
  end
end

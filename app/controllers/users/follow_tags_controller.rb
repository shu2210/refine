# frozen_string_literal: true

class Users::FollowTagsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tags = Tag.all
  end

  def create
    params[:tags] ||= []
    if current_user.follow_tags(params[:tags])
      redirect_to root_path
    else
      render :new
    end
  end
end

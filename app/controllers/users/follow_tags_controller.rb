# frozen_string_literal: true

class Users::FollowTagsController < ApplicationController
  before_action :authenticate_user!

  def new; end
end

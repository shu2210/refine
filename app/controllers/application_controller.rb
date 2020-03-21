# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def icon_url(user)
    return unless user.icon&.attached?

    url_for(user.icon)
  end
end

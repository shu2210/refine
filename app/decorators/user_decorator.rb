# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def attached_icon
    icon.attached? ? icon : 'default.jpeg'
  end
end

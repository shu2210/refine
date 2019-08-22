# frozen_string_literal: true

module ApplicationHelper
  def display_flash_messages(model)
    if model.errors.any?
      model_error(model)
    elsif flash.any?
      flash_message
    end
  end

  private

  def model_error(model)
    column = model.flash_columns.first

    if model.errors[column].any?
      build_flash_html :danger, model.errors.full_messages_for(column).first
    else
      build_flash_html :danger, t('errors.invalid')
    end
  end

  def flash_message
    flash.each do |key, value|
      case key.to_sym
      when :alert
        return build_flash_html :danger, value
      when :notice
        return build_flash_html :primary, value
      else
        return build_flash_html :success, value
      end
    end
  end

  def build_flash_html(flash_type, message)
    tag.div class: "uk-alert-#{flash_type}", 'uk-alert': '' do |tag|
      concat tag.a '', class: 'uk-alert-close', 'uk-close': ''
      concat tag.span message, class: 'uk-text-small'
    end
  end
end

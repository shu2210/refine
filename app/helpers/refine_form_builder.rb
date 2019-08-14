# frozen_string_literal: true

class RefineFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :concat, to: :@template

  def icon_field(icon)
    @template.content_tag :div, class: 'uk-inline uk-width-1-1' do
      concat @template.content_tag(:span, '', class: 'uk-form-icon', 'uk-icon': "icon: #{icon}")
      concat yield
    end
  end

  def email_field_with_icon(attribute, options = {})
    @template.content_tag :div, class: 'uk-margin' do
      concat icon_field(:mail) { email_field(attribute, options) }
      concat error_message(attribute)
    end
  end

  def password_field_with_icon(attribute, options = {})
    @template.content_tag :div, class: 'uk-margin' do
      concat icon_field(:lock) { password_field(attribute, options) }
      concat error_message(attribute)
    end
  end

  private

  def error_message(attribute)
    @template.content_tag :span, class: 'uk-text-small uk-text-danger' do
      @object.errors.full_messages_for(attribute).first
    end
  end
end

# frozen_string_literal: true

require 'active_support/concern'

module CodePermittable
  extend ActiveSupport::Concern

  def codes
    params[:code].each(&:permit!)
    params[:code].map do |code|
      code = Code.new(code)
      code.valid?
      code
    end
  end
end

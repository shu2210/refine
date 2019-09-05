# frozen_string_literal: true

require 'active_support/concern'

module FlashValidatable
  extend ActiveSupport::Concern

  included do
    class_attribute :flash_columns
  end

  class_methods do
    def flash_validation(*columns)
      self.flash_columns = columns
    end
  end
end

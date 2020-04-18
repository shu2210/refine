# frozen_string_literal: true

class Code < ApplicationRecord
  extend Enumerize

  belongs_to :language
  belongs_to :user_code

  validates :code, presence: true, unless: -> { validation_context == :draft }
end

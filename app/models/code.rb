# frozen_string_literal: true

class Code < ApplicationRecord
  extend Enumerize

  belongs_to :language

  validates :code, presence: true
end

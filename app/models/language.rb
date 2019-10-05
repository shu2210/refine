# frozen_string_literal: true

class Language < ApplicationRecord
  validates :mode, presence: true, length: { maximum: 100 }
  validates :name, presence: true, length: { maximum: 100 }
end

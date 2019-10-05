# frozen_string_literal: true

class Code < ApplicationRecord
  has_one :language

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :code, presence: true
end

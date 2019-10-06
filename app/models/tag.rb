# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :codes, through: :code_tags

  validates :name, presence: true, length: { maximum: 100 }
end

# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :code
  belongs_to :user

  validates :review, presence: true, length: { maximum: 500 }
end

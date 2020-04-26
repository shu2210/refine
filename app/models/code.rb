# frozen_string_literal: true

class Code < ApplicationRecord
  extend Enumerize

  belongs_to :language
  belongs_to :user_code

  has_many :reviews

  validates :code, presence: true, unless: -> { validation_context == :draft }

  def self.review_count
    all.sum do |code|
      code.reviews.count
    end
  end
end

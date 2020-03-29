# frozen_string_literal: true

require_relative 'concerns/array_parsable'

class Review < ApplicationRecord
  include ArrayParsable

  acts_as_paranoid

  belongs_to :code
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :review, presence: true, length: { maximum: 500 }

  def self.array_with_comments
    reviews = includes(:comments).order(:created_at)
    reviews.map do |review|
      hash = review.attributes
      hash['comments'] = review.comments.map(&:attributes)
      hash
    end
  end
end

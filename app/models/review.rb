# frozen_string_literal: true

class Review < ApplicationRecord
  acts_as_paranoid

  belongs_to :code
  belongs_to :user

  has_many :comments

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

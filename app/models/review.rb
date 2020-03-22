# frozen_string_literal: true

class Review < ApplicationRecord
  acts_as_paranoid

  belongs_to :code
  belongs_to :user

  has_many :comments

  validates :review, presence: true, length: { maximum: 500 }

  def self.array_with_comments
    json_with_comments = order(:created_at)&.to_json(include: :comments)
    JSON.parse(json_with_comments)
  end
end

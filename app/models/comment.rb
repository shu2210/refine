# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :comment, presence: true

  def self.array_with_user
    json_with_user = order(created_at: :desc)&.to_json(include: :user)
    JSON.parse(json_with_user)
  end
end

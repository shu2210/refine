# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :comment, presence: true

  def self.array_with_user
    comments = includes(:user).order(created_at: :desc)
    comments.map(&:array_with_user)
  end

  def array_with_user
    hash_with_user = attributes_with(:user)
    hash_with_user['user']['icon'] = user.icon_url
    hash_with_user
  end

  def attributes_with(model)
    attributes = self.attributes
    attributes[model] = send(model).attributes
    attributes.with_indifferent_access
  end
end

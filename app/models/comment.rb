# frozen_string_literal: true

class Comment < ApplicationRecord
  include ArrayParsable

  acts_as_paranoid

  belongs_to :user
  belongs_to :review

  validates :comment, presence: true
end

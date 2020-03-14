# frozen_string_literal: true

class Review < ApplicationRecord
  acts_as_paranoid

  belongs_to :code
  belongs_to :user

  has_many :comments

  validates :review, presence: true, length: { maximum: 500 }
end

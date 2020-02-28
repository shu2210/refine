# frozen_string_literal: true

class UserCode < ApplicationRecord
  extend Enumerize

  belongs_to :user

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 300 }

  enumerize :status, in: %i[draft published closed]
end

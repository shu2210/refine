# frozen_string_literal: true

class Code < ApplicationRecord
  belongs_to :user
  has_one :language

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :code, presence: true

  enum status: %i[draft published closed]

  def post(user)
    self.status = :published
    self.user = user
    save
  end

  def draft
    self.status = :draft
    save(validate: false)
  end
end

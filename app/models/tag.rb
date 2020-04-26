# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :user_code_tags
  has_many :user_codes, through: :user_code_tags

  validates :name, presence: true, length: { maximum: 100 }

  scope :popular, lambda {
    joins(:user_codes)
      .group('tags.name')
      .select('tags.name', 'COUNT(*) AS count')
      .order(
        Arel.sql('count DESC')
      )
      .limit(5)
  }
end

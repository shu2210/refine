# frozen_string_literal: true

require_relative 'concerns/array_parsable'

class Comment < ApplicationRecord
  include ArrayParsable

  belongs_to :user
  belongs_to :review

  validates :comment, presence: true
end

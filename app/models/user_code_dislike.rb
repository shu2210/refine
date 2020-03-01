# frozen_string_literal: true

class UserCodeDislike < ApplicationRecord
  belongs_to :user
  belongs_to :user_code

  validates :user_id, uniqueness: { scope: :user_code_id }
end

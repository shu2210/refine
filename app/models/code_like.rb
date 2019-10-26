# frozen_string_literal: true

class CodeLike < ApplicationRecord
  belongs_to :user
  belongs_to :code

  validates :user_id, uniqueness: { scope: :code_id }
end

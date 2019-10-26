# frozen_string_literal: true

class CodeLike < ApplicationRecord
  belongs_to :user
  belongs_to :code
end

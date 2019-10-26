# frozen_string_literal: true

class CodeDislike < ApplicationRecord
  belongs_to :user
  belongs_to :code
end

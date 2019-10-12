# frozen_string_literal: true

class CodeTag < ApplicationRecord
  belongs_to :code
  belongs_to :tag
end

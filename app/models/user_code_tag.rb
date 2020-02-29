# frozen_string_literal: true

class UserCodeTag < ApplicationRecord
  belongs_to :user_code
  belongs_to :tag
end

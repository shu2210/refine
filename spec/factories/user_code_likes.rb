# frozen_string_literal: true

FactoryBot.define do
  factory :user_code_like do
    user { build(:user) }
    user_code { build(:user_code) }
  end
end

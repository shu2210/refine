# frozen_string_literal: true

FactoryBot.define do
  factory :code do
    user_code { build(:user_code) }
    code { 'test' }
    language { build(:language) }
  end
end

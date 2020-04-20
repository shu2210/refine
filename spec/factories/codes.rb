# frozen_string_literal: true

FactoryBot.define do
  factory :code do
    code { 'test' }
    association :user_code
    association :language
  end
end

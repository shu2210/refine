# frozen_string_literal: true

FactoryBot.define do
  factory :user_code_dislike do
    association :user
    association :user_code
  end
end

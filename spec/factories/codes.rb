# frozen_string_literal: true

FactoryBot.define do
  factory :code do
    code { Faker::Lorem.characters }
    association :user_code
    association :language
  end
end

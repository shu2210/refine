# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number: 10) }
    association :user
    association :review
  end
end

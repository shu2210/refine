# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    line { 1 }
    review { Faker::Lorem.characters(number: 10) }
    association :code
    association :user
  end
end

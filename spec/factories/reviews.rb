# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    code { build(:code) }
    user { build(:user) }
    line { 1 }
    review { Faker::Lorem.characters(number: 10) }
  end
end

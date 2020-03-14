# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user { build(:user) }
    review { build(:review) }
    comment { Faker::Lorem.characters(number: 10) }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user_code do
    status { :post }
    title { Faker::Lorem.characters }
    description { Faker::Lorem.characters }
    association :user
  end
end

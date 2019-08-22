# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
    confirmed_at { Time.now }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user_code do
    status { :post }
    title { 'test' }
    description { 'description' }
    association :user
  end
end

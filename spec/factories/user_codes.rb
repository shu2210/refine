# frozen_string_literal: true

FactoryBot.define do
  factory :user_code do
    user { build(:user) }
    status { :post }
    title { 'test' }
    description { 'description' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :code do
    title { 'test' }
    description { 'description' }
    code { 'test' }
    user { build(:user) }
  end
end

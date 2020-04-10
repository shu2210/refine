# frozen_string_literal: true

FactoryBot.define do
  factory :user_code do
    user { build(:user) }
    status { :published }
    title { 'test' }
    description { 'description' }
    version { 1 }
  end
end

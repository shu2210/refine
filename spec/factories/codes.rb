# frozen_string_literal: true

FactoryBot.define do
  factory :code do
    code { 'test' }
    language { build(:language) }
  end
end

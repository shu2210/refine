# frozen_string_literal: true

FactoryBot.define do
  factory :code_dislike do
    user { build(:user) }
    code { build(:code) }
  end
end

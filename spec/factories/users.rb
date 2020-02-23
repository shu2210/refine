# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
    confirmed_at { Time.now }

    trait :with_icon do
      icon do
        image_file = Rails.root.join('spec', 'support', 'assets', 'test-image.png')
        Rack::Test::UploadedFile.new(image_file, 'image/png')
      end
    end
  end
end

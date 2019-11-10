# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  it '正常に保存できる' do
    review = build(:review)
    expect(review).to be_valid
  end

  describe 'review' do
    let(:model) { build(:review, review: review) }
    before { model.valid? }

    context '空白の場合' do
      let(:review) { '' }

      it { expect(model.errors[:review]).not_to be_empty }
    end

    context '長すぎる場合' do
      let(:review) { Faker::Lorem.characters(number: 501) }

      it { expect(model.errors[:review]).not_to be_empty }
    end
  end
end

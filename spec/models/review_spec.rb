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

  describe 'array_with' do
    let!(:comment) { build(:comment) }
    let!(:review) { create(:review, comments: [comment]) }

    context 'commentsを渡した場合' do
      it 'commentを含めた配列を返す' do
        reviews = Review.where(id: review.id)
        array = reviews.array_with(:comments)
        array.each do |comment|
          expect(comment['comments']).to be_any
        end
      end
    end

    context 'user, commentsを渡した場合' do
      it 'user, commentsを含めた配列を返す' do
        reviews = Review.where(id: review.id)
        array = reviews.array_with(:comments, :user)
        array.each do |comment|
          expect(comment['comments']).to be_any
          expect(comment['user']).to be_any
        end
      end
    end
  end
end

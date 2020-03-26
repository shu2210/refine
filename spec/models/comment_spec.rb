# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }

  it '正常にビルドできること' do
    expect(comment).to be_valid
  end

  describe 'comment' do
    context '空の場合' do
      let(:comment) { build(:comment, comment: '') }

      it { expect(comment).to be_invalid }
    end
  end

  describe 'array_with_user' do
    let!(:user) { build(:user) }
    let!(:comment1) { create(:comment, user: user) }
    let!(:comment2) { create(:comment, user: user) }

    it 'userを含めた配列を返す' do
      comments = Comment.where(user_id: user.id)
      array = comments.array_with_user
      array.each do |comment|
        expect(comment['user']).to be_any
      end
    end
  end

  describe 'attributes_with' do
    context 'userを渡した場合' do
      let!(:user) { build(:user) }
      let!(:comment) { build(:comment, user: user) }

      it 'userを含むhashを返す' do
        hash = comment.attributes_with(:user)
        expect(hash['user']).to eq(user.attributes)
        expect(hash[:user]).to eq(user.attributes)
      end
    end

    context 'reviewを渡した場合' do
      let!(:review) { build(:review) }
      let!(:comment) { build(:comment, review: review) }

      it 'reviewを含むhashを返す' do
        hash = comment.attributes_with(:review)
        expect(hash['review']).to eq(review.attributes)
        expect(hash[:review]).to eq(review.attributes)
      end
    end

    context '引数に文字列を渡した場合' do
      let!(:review) { build(:review) }
      let!(:comment) { build(:comment, review: review) }

      it '引数に渡したモデルを含むhashを返す' do
        hash = comment.attributes_with('review')
        expect(hash['review']).to eq(review.attributes)
        expect(hash[:review]).to eq(review.attributes)
      end
    end

    context 'アソシエーションがないモデルを引数に渡した場合' do
      let!(:comment) { build(:comment) }

      it 'エラーになる' do
        expect { comment.attributes_with(:test) }.to raise_error(StandardError)
      end
    end
  end
end

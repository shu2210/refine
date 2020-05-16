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

  describe 'self.array_with' do
    let(:user) { build(:user) }
    let(:comment1) { create(:comment, user: user) }
    let(:comment2) { create(:comment, user: user) }

    context 'userを渡した場合' do
      it 'userを含むarrayが返る' do
        comments = Comment.where(id: [comment1.id, comment2.id])
        hash = comments.array_with(:user)
        hash.each do |record|
          expect(record['user']).to be_any
        end
      end
    end
  end

  describe 'hash_with' do
    let(:user) { build(:user) }
    let(:comment) { create(:comment, user: user) }

    context 'userを渡した場合' do
      let(:user) { build(:user) }
      let(:comment) { build(:comment, user: user) }

      it 'userを含むhashを返す' do
        hash = comment.hash_with(:user)
        expect(hash['user']).to eq(user.attributes)
        expect(hash[:user]).to eq(user.attributes)
      end
    end

    context 'reviewを渡した場合' do
      let(:review) { build(:review) }
      let(:comment) { build(:comment, review: review) }

      it 'reviewを含むhashを返す' do
        hash = comment.hash_with(:review)
        expect(hash['review']).to eq(review.attributes)
        expect(hash[:review]).to eq(review.attributes)
      end
    end

    context '引数に文字列を渡した場合' do
      let(:review) { build(:review) }
      let(:comment) { build(:comment, review: review) }

      it '引数に渡したモデルを含むhashを返す' do
        hash = comment.hash_with('review')
        expect(hash['review']).to eq(review.attributes)
        expect(hash[:review]).to eq(review.attributes)
      end
    end

    context 'アソシエーションがないモデルを引数に渡した場合' do
      let(:comment) { build(:comment) }

      it 'エラーになる' do
        expect { comment.hash_with(:test) }.to raise_error(StandardError)
      end
    end
  end
end

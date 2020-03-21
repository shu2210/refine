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
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCode, type: :model do
  context '正常な場合' do
    it 'エラーにならない' do
      code = build(:user_code)
      expect(code).to be_valid
    end
  end

  describe 'title' do
    let(:code) { build(:user_code, title: title) }
    before { code.valid? }

    context '空白の場合' do
      let(:title) { '' }

      it { expect(code.errors[:title]).not_to be_empty }
    end

    context '200文字以上の場合' do
      let(:title) { Faker::Lorem.characters(number: 201) }

      it { expect(code.errors[:title]).not_to be_empty }
    end
  end

  describe 'description' do
    let(:code) { build(:user_code, description: description) }
    before { code.valid? }

    context '空白の場合' do
      let(:description) { '' }

      it { expect(code.errors[:description]).not_to be_empty }
    end

    context '300文字以上の場合' do
      let(:description) { Faker::Lorem.characters(number: 301) }

      it { expect(code.errors[:description]).not_to be_empty }
    end
  end

  describe 'draft' do
    it '下書き保存ができること' do
      code = UserCode.new(title: 'test')
      expect { code.draft }.to change(UserCode, :count).by(1)
    end

    it 'statusがdraftになること' do
      code = UserCode.new(title: 'test')
      code.draft
      expect(code.status).to eq('draft')
    end
  end

  describe 'likes' do
    let(:code) { create(:user_code) }

    context 'likesがない場合' do
      it '0を返す' do
        expect(code.likes).to eq(0)
      end
    end

    context 'likesがある場合' do
      before do
        create(:user_code_like, user_code_id: code.id)
        create(:user_code_like, user_code_id: code.id)
      end

      it 'likeの数を返す' do
        expect(code.likes).to eq(2)
      end
    end
  end

  describe 'liked?' do
    let(:code) { create(:user_code) }

    context 'likeがある場合' do
      let(:like) { create(:user_code_like, user_code_id: code.id) }

      it 'trueを返す' do
        expect(code.liked?(like.user_id)).to be_truthy
      end
    end

    context 'likeがない場合' do
      it 'falseを返す' do
        expect(code.liked?(0)).to be_falsy
      end
    end
  end

  describe 'dislikes' do
    let(:code) { create(:user_code) }

    context 'dislikesがない場合' do
      it '0を返す' do
        expect(code.dislikes).to eq(0)
      end
    end

    context 'dislikesがある場合' do
      before do
        create(:user_code_dislike, user_code_id: code.id)
        create(:user_code_dislike, user_code_id: code.id)
      end

      it 'likeの数を返す' do
        expect(code.dislikes).to eq(2)
      end
    end
  end

  describe 'disliked?' do
    let(:code) { create(:user_code) }

    context 'dislikeがある場合' do
      let(:dislike) { create(:user_code_dislike, user_code_id: code.id) }

      it 'trueを返す' do
        expect(code.disliked?(dislike.user_id)).to be_truthy
      end
    end

    context 'dislikeがない場合' do
      it 'falseを返す' do
        expect(code.disliked?(0)).to be_falsy
      end
    end
  end
end

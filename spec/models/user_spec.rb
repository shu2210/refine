# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it '正常にビルドできること' do
    expect(user).to be_valid
  end

  describe 'name' do
    context '新規登録の場合' do
      it 'メールアドレスの@より前になる' do
        create(:user, email: 'test@example.com')
        expect(User.last.name).to eq('test')
      end
    end

    context 'profileのupdateの場合で空の場合' do
      it 'エラーになる' do
        user.name = ''
        expect(user.valid?(:profile)).to eq(false)
      end
    end
  end

  describe 'flash_columns' do
    it 'flash_columnを持っていること' do
      expect(user).to respond_to(:flash_columns)
    end

    it 'flash_columnsにはmodelで指定したカラムが入っていること' do
      expect(user.flash_columns).to include(:reset_password_token)
    end
  end

  describe 'email' do
    before do
      user.email = email
      user.valid?
    end

    context '正常な値の場合' do
      let(:email) { Faker::Internet.email }
      it { expect(user).to be_valid }
    end

    context 'フォーマットが不正な場合' do
      let(:email) { Faker::Lorem.characters }
      it { expect(user).not_to be_valid }
    end
  end

  describe 'password' do
    before do
      user.password = password
      user.valid?
    end

    context '正常な値の場合' do
      let(:password) { Faker::Lorem.characters(number: 6) }
      it { expect(user).to be_valid }
    end

    context '長すぎる場合' do
      let(:password) { Faker::Lorem.characters(number: 200) }
      it { expect(user).not_to be_valid }
    end

    context '短すぎる場合' do
      let(:password) { Faker::Lorem.characters(number: 2) }
      it { expect(user).not_to be_valid }
    end
  end

  describe 'description' do
    context '長すぎる場合' do
      it 'エラーになる' do
        user.description = Faker::Lorem.characters(number: 256)
        expect(user.valid?(:profile)).to eq(false)
      end
    end
  end

  describe 'posted_codes' do
    context 'ユーザーに投稿したコードがある場合' do
      let!(:code) { create(:user_code, user_id: post_user.id) }
      let(:post_user) { create(:user) }

      it 'ユーザーが投稿したコードを10件取得する' do
        codes = post_user.posted_codes
        expect(codes.first).to eq(code)
      end
    end

    context 'ユーザーに投稿したコードがない場合' do
      it '空の配列が返る' do
        codes = user.posted_codes
        expect(codes).to be_empty
      end
    end
  end

  describe 'liked_codes' do
    let(:code) { create(:user_code, user_id: post_user.id) }
    let(:post_user) { create(:user) }

    context 'いいねしたコードがあった場合' do
      let!(:code_like) { create(:user_code_like, user_code_id: code.id, user_id: post_user.id) }

      it 'いいねしたコードが返る' do
        codes = post_user.liked_codes
        expect(codes.first).to eq(code)
      end
    end

    context 'いいねしたコードがない場合' do
      it '空の配列が返る' do
        codes = post_user.liked_codes
        expect(codes).to be_empty
      end
    end
  end

  describe 'reviewed_codes' do
    let(:code) { create(:code) }
    let(:post_user) { create(:user) }

    context 'レビューしたコードがあった場合' do
      let!(:review) { create(:review, code_id: code.id, user_id: post_user.id) }

      it 'レビューしたコードが返る' do
        codes = post_user.reviewed_codes
        expect(codes.first).to eq(code.user_code)
      end
    end

    context 'レビューしたコードがない場合' do
      it '空の配列が返る' do
        codes = post_user.reviewed_codes
        expect(codes).to be_empty
      end
    end
  end

  describe 'sns_registration?' do
    context 'snsで登録していた場合' do
      it 'trueが返る' do
        user = build(:user, provider: 'google')
        expect(user.sns_registration?).to eq(true)
      end
    end

    context 'メールアドレスで登録していた場合' do
      it 'falseが返る' do
        user = build(:user, provider: nil)
        expect(user.sns_registration?).to eq(false)
      end
    end
  end

  describe 'follow_tags' do
    context 'tagが一つもない場合' do
      it 'falseが返る' do
        expect(user.follow_tags([])).to eq(false)
      end
    end

    context 'tagがある場合' do
      before { create(:tag, name: 'Rails') }
      let(:tags) { %w[Rails Ruby] }

      it 'user_tagsが登録される' do
        expect { user.follow_tags(tags) }.to change(UserTag, :count).by(2)
      end

      it 'tagに登録されていない物が登録される' do
        expect { user.follow_tags(tags) }.to change(Tag, :count).by(1)
      end

      it 'truthyが返る' do
        expect(user.follow_tags(tags)).to be_truthy
      end
    end
  end
end

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
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language, type: :model do
  it '正常に登録できる' do
    language = build(:language)
    language.valid?
    expect(language).to be_valid
  end

  describe 'mode' do
    let(:language) { build(:language, mode: mode) }
    before { language.valid? }

    context '空白の場合' do
      let(:mode) { '' }

      it { expect(language.errors[:mode]).not_to be_empty }
    end

    context '100文字以上の場合' do
      let(:mode) { Faker::Lorem.characters(number: 101) }

      it { expect(language.errors[:mode]).not_to be_empty }
    end
  end

  describe 'name' do
    let(:language) { build(:language, name: name) }
    before { language.valid? }

    context '空白の場合' do
      let(:name) { '' }

      it { expect(language.errors[:name]).not_to be_empty }
    end

    context '100文字以上の場合' do
      let(:name) { Faker::Lorem.characters(number: 101) }

      it { expect(language.errors[:name]).not_to be_empty }
    end
  end
end

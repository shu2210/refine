# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it '正常に登録できること' do
    tag = build(:tag)
    expect(tag).to be_valid
  end

  describe 'name' do
    let(:tag) { build(:tag, name: name) }
    before { tag.valid? }

    context '空白の場合' do
      let(:name) { '' }

      it { expect(tag.errors[:name]).not_to be_empty }
    end

    context '100文字以上の場合' do
      let(:name) { Faker::Lorem.characters(number: 101) }

      it { expect(tag.errors[:name]).not_to be_empty }
    end
  end
end

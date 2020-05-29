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

  describe 'scope' do
    describe 'popular' do
      let(:rails) { create(:tag, name: 'Rails') }
      let(:ruby) { create(:tag, name: 'Ruby') }
      let(:python) { create(:tag, name: 'Python') }
      let(:js) { create(:tag, name: 'Javascript') }
      let(:go) { create(:tag, name: 'Go') }
      let(:rust) { create(:tag, name: 'Rust') }

      before do
        create_list(:user_code, 2, active: true, tags: [python])
        create(:user_code, active: true, tags: [rails])
        create(:user_code, active: true, tags: [ruby])
        create(:user_code, active: true, tags: [js])
        create(:user_code, active: true, tags: [go])
      end

      it '紐づくuser_codeの数が多いタグが5件まで取得できる' do
        tags = Tag.popular
        expect(tags).not_to include(rust)
        expect(tags.first.name).to eq(python.name)
      end
    end
  end
end

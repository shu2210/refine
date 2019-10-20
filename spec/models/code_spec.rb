# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Code, type: :model do
  context '正常な場合' do
    it 'エラーにならない' do
      code = build(:code)
      expect(code).to be_valid
    end
  end

  describe 'title' do
    let(:code) { build(:code, title: title) }
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
    let(:code) { build(:code, description: description) }
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

  describe 'code' do
    let(:code) { build(:code, code: code_value) }
    before { code.valid? }

    context '空白の場合' do
      let(:code_value) { '' }

      it { expect(code.errors[:code]).not_to be_empty }
    end
  end

  describe 'draft' do
    it '下書き保存ができること' do
      code = Code.new(code: 'test')
      expect { code.draft }.to change(Code, :count).by(1)
    end

    it 'statusがdraftになること' do
      code = Code.new(code: 'test')
      code.draft
      expect(code.status).to eq('draft')
    end
  end
end

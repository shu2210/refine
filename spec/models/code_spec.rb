# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCode, type: :model do
  describe 'code' do
    let(:code) { build(:code, code: code_value) }

    context 'postの場合' do
      before { code.valid? }

      context '空白の場合' do
        let(:code_value) { '' }

        it { expect(code.errors[:code]).not_to be_empty }
      end
    end

    context 'draftの場合' do
      before { code.valid?(:draft) }

      context '空白の場合' do
        let(:code_value) { '' }

        it { expect(code.errors[:code]).to be_empty }
      end
    end
  end

  describe 'self.review_count' do
    let(:code1) { create(:code, reviews: [build(:review), build(:review)]) }
    let(:code2) { create(:code, reviews: [build(:review)]) }

    it 'reviewの数の合計を返す' do
      count = Code.where(id: [code1.id, code2.id]).review_count
      expect(count).to eq(3)
    end
  end
end

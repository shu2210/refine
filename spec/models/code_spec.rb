# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCode, type: :model do
  describe 'code' do
    let(:code) { build(:code, code: code_value) }
    before { code.valid? }

    context '空白の場合' do
      let(:code_value) { '' }

      it { expect(code.errors[:code]).not_to be_empty }
    end
  end
end

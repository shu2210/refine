# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodeLike, type: :model do
  context '同じユーザーが同じコードに登録する場合' do
    let(:user) { build(:user) }
    let(:code) { build(:code) }
    before { create(:code_like, user: user, code: code) }

    it 'エラーになる' do
      like = CodeLike.new(user: user, code: code)
      like.valid?
      expect(like.errors).not_to be_empty
    end
  end
end

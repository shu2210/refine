# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCodeLike, type: :model do
  context '同じユーザーが同じコードに登録する場合' do
    let(:user) { build(:user) }
    let(:code) { build(:user_code) }
    before { create(:user_code_like, user: user, user_code: code) }

    it 'エラーになる' do
      like = UserCodeLike.new(user: user, user_code: code)
      like.valid?
      expect(like.errors[:user_id]).not_to be_empty
    end
  end
end

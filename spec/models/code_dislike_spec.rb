# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodeDislike, type: :model do
  context '同じユーザーが同じコードに登録する場合' do
    let(:user) { build(:user) }
    let(:code) { build(:code) }
    before { create(:code_dislike, user: user, code: code) }

    it 'エラーになる' do
      dislike = CodeDislike.new(user: user, code: code)
      dislike.valid?
      expect(dislike.errors).not_to be_empty
    end
  end
end

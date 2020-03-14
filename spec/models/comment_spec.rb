# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }

  it '正常にビルドできること' do
    expect(comment).to be_valid
  end

  describe 'comment' do
    context '空の場合' do
      let(:comment) { build(:comment, comment: '') }

      it { expect(comment).to be_invalid }
    end
  end
end

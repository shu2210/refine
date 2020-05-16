# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'icon' do
    context 'アイコンがある場合' do
      let(:user) { build(:user, :with_icon).decorate }

      it 'そのアイコンを返す' do
        expect(user.attached_icon).to eq(user.icon)
      end
    end

    context 'アイコンがない場合' do
      let(:user) { build(:user).decorate }

      it 'デフォルトのアイコンのパスを返す' do
        expect(user.attached_icon).to eq('default.jpeg')
      end
    end
  end
end

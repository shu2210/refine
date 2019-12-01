# frozen_string_literal: true

require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe 'display_flash_messages' do
    let(:user) { build(:user) }

    context '初期表示の場合(全くエラーが無い場合)' do
      it '何も返されない' do
        html = helper.display_flash_messages(user)
        expect(html).to be_nil
      end
    end

    context 'flash_columnにエラーがある場合' do
      let!(:error_message) { Faker::Lorem.characters }

      it 'flash_columnのエラーが出力される' do
        user.errors.add(:reset_password_token, error_message)
        html = helper.display_flash_messages(user)
        expect(html).to include(error_message)
      end
    end

    context 'flash_columnにエラーが無い場合' do
      context 'フラッシュメッセージがある場合' do
        let!(:error_message) { Faker::Lorem.characters }

        it 'フラッシュメッセージが出力される' do
          flash[:alert] = error_message
          html = helper.display_flash_messages(user)
          expect(html).to include(error_message)
        end
      end

      context 'その他のカラムにエラーがある場合' do
        it 'デフォルトのメッセージが出力される' do
          user.errors.add(:email, 'invalid')
          html = helper.display_flash_messages(user)
          expect(html).to include(t('errors.invalid'))
        end
      end
    end
  end
end

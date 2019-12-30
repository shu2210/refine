# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ChangePasswordsController, type: :controller do
  let(:user) { create(:user) }

  shared_examples 'ログイン画面へリダイレクトされる' do
    it { is_expected.to have_http_status(:redirect) }
    it { is_expected.to redirect_to('/users/sign_in') }
  end

  describe 'PUT #update' do
    context 'ログインしていない場合' do
      subject { put :update, params: { id: user.id } }

      it_behaves_like 'ログイン画面へリダイレクトされる'
    end

    context 'ログインしている場合' do
      before { sign_in user }

      let(:new_password) { Faker::Lorem.characters(number: 10) }
      let(:wrong_password) { Faker::Lorem.characters(number: 10) }

      context '成功の場合' do
        let(:params) { { id: user.id, user: { current_password: user.password, new_password: new_password, new_password_confirmation: new_password } } }

        it 'profiles/editがrenderされる' do
          put :update, params: params
          expect(response).to render_template('users/profiles/edit')
        end

        it 'flash[:success]が設定される' do
          put :update, params: params
          expect(flash[:success]).to eq(I18n.t('saved'))
        end
      end

      context 'パスワードとパスワード確認が違う場合' do
        let(:params) { { id: user.id, user: { current_password: user.password, new_password: new_password, new_password_confirmation: wrong_password } } }

        it 'flash[:alert]が設定される' do
          put :update, params: params
          expect(flash[:alert]).to eq(I18n.t('errors.invalid'))
        end
      end

      context '現在のパスワードが違う場合' do
        let(:params) { { id: user.id, user: { current_password: wrong_password, new_password: new_password, new_password_confirmation: new_password } } }

        it 'flash[:alert]が設定される' do
          put :update, params: params
          expect(flash[:alert]).to eq(I18n.t('errors.invalid'))
        end
      end

      context 'バリデーションエラーの場合' do
        let(:params) { { id: user.id, user: { current_password: user.password, new_password: '', new_password_confirmation: '' } } }

        it 'flash[:alert]が設定される' do
          put :update, params: params
          expect(flash[:alert]).to eq(I18n.t('errors.invalid'))
        end
      end
    end
  end
end

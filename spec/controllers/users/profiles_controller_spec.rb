# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ProfilesController, type: :controller do
  let(:user) { create(:user) }

  shared_examples 'ログイン画面へリダイレクトされる' do
    it { is_expected.to have_http_status(:redirect) }
    it { is_expected.to redirect_to('/users/sign_in') }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: user.id } }

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトされる'
    end

    context 'ログインしている場合' do
      before { sign_in user }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:show) }
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: user.id } }

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトされる'
    end

    context 'ログインしている場合' do
      before { sign_in user }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:edit) }
    end
  end

  describe 'PUT #update' do
    context 'ログインしていない場合' do
      subject { put :update, params: params }
      let(:params) { { id: user.id } }

      it_behaves_like 'ログイン画面へリダイレクトされる'
    end

    context 'ログインしている場合' do
      before { sign_in user }

      context '異常がある場合' do
        let(:params) { { id: user.id, users: { name: '' } } }
        before { put :update, params: params }

        it 'editをrenderする' do
          expect(response).to render_template(:edit)
        end

        it 'エラーメッセージが表示される' do
          expect(flash[:error]). to eq(I18n.t('errors.invalid'))
        end
      end

      context '正常な場合' do
        let(:new_name) { Faker::Name.name }
        let(:description) { Faker::Lorem.characters(number: 100) }
        let(:params) { { id: user.id, users: { name: new_name, description: description } } }
        before { put :update, params: params }

        it 'ユーザー名がupdateされる' do
          user.reload
          expect(user.name).to eq(new_name)
        end

        it '説明がupdateされる' do
          user.reload
          expect(user.description).to eq(description)
        end

        it '画像がupdateされる'
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Codes::DraftsController, type: :controller do
  describe 'GET #index' do
    context 'ログインしていない場合' do
      subject { get :index }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      before { sign_in_user }

      subject { get :index }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:index) }
    end
  end

  describe 'POST #create' do
    context 'ログインしていない場合' do
      subject { post :create }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let!(:language) { Language.first }

      before { sign_in_user }

      context '成功した場合' do
        let!(:params) { { user_code: { title: 'test', description: 'test' }, code: [{ language_id: language.id, code: 'test' }] } }

        it 'user_codeが作成されること' do
          expect { post :create, params: params }.to change(UserCode, :count).by(1)
        end

        it 'codeが作成されること' do
          expect { post :create, params: params }.to change(Code, :count).by(1)
        end

        it '下書き一覧にリダイレクトする' do
          post :create, params: params
          expect(response).to redirect_to(codes_drafts_path)
        end
      end

      context '失敗した場合' do
        let!(:params) { { user_code: { title: '', description: 'test' }, code: [{ language_id: language.id, code: 'test' }] } }

        it 'レコードは作成されない' do
          expect { post :create, params: params }.not_to change(UserCode, :count)
        end

        it 'コード投稿画面をrenderする' do
          post :create, params: params
          expect(response).to render_template('codes/new')
        end
      end
    end
  end
end

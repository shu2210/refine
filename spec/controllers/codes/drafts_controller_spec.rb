# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Codes::DraftsController, type: :controller do
  describe 'POST #create' do
    context 'ログインしていない場合' do
      subject { post :create }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let!(:language) { Language.first }
      let!(:params) { { user_code: { title: 'test', description: 'test' }, code: [{ language_id: language.id, code: 'test' }] } }

      before { sign_in_user }

      it 'user_codeが作成されること' do
        expect { post :create, params: params }.to change(UserCode, :count).by(1)
      end

      it 'codeが作成されること' do
        expect { post :create, params: params }.to change(Code, :count).by(1)
      end

      it 'root_pathにリダイレクトする' do
        post :create, params: params
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Codes::DislikesController, type: :controller do
  describe 'POST #create' do
    context 'ログインしていない場合' do
      subject { post :create }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let(:user) { create(:user) }
      before { sign_in user }

      context '成功した場合' do
        let(:code) { create(:user_code) }
        let(:params) { { code_id: code.id } }

        it 'code_dislikesを増やす' do
          expect { post :create, params: params }.to change(UserCodeDislike, :count).by(1)
        end

        it 'status => success' do
          post :create, params: params
          expect(response).to be_json_success
        end
      end

      context 'エラーの場合' do
        let(:params) { { code_id: 0 } }

        it 'status => error' do
          post :create, params: params
          expect(response).to be_json_error
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしていない場合' do
      subject { delete :destroy, params: { id: 1 } }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let(:user) { create(:user) }
      let(:code) { create(:user_code) }

      before do
        create(:user_code_dislike, user_id: user.id, user_code_id: code.id)
        sign_in user
      end

      context '成功した場合' do
        let(:params) { { id: code.id } }

        it 'code_dislikesを減らす' do
          expect { delete :destroy, params: params }.to change(UserCodeDislike, :count).by(-1)
        end

        it 'status => success' do
          delete :destroy, params: params
          expect(response).to be_json_success
        end
      end

      context 'エラーの場合' do
        let(:params) { { id: 0 } }

        it 'status => error' do
          delete :destroy, params: params
          expect(response).to be_json_error
        end
      end
    end
  end
end

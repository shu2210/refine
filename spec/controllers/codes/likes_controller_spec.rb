# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Codes::LikesController, type: :controller do
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
        let(:code) { create(:code) }
        let(:params) { { code_id: code.id } }

        it 'code_likesを増やす' do
          expect { post :create, params: params }.to change(CodeLike, :count).by(1)
        end

        it 'status => success' do
          post :create, params: params
          body = JSON.parse(response.body)
          expect(body['status']).to eq('success')
        end
      end

      context 'エラーの場合' do
        let(:params) { { code_id: 0 } }

        it 'status => error' do
          post :create, params: params
          body = JSON.parse(response.body)
          expect(body['status']).to eq('error')
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::FollowTagsController, type: :controller do
  describe 'GET #new' do
    context 'ログインしていない場合' do
      subject { get :new }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let(:user) { create(:user) }
      before { sign_in user }

      subject { get :new }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:new) }
    end
  end

  describe 'POST #create' do
    context 'ログインしていない場合' do
      subject { post :create }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let(:user) { create(:user) }
      before { sign_in user }

      context '正常な場合' do
        let(:params) { { tags: %w[Rails Ruby] } }

        it 'user_tagsが登録される' do
          expect { post :create, params: params }.to change(UserTag, :count).by(2)
        end

        it 'リダイレクトされる' do
          post :create, params: params
          expect(response).to redirect_to(root_path)
        end
      end

      context 'エラーの場合' do
        let(:params) { { tags: [] } }

        it 'newをrenderする' do
          post :create, params: params
          expect(response).to render_template(:new)
        end
      end
    end
  end
end

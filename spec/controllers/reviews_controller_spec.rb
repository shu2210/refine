# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  shared_context :login do
    let(:user) { create(:user, :with_icon) }
    before { sign_in user }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: 1 } }
    let!(:code) { create(:code) }
    let!(:review) { create(:review, code_id: code.id) }

    it { is_expected.to have_http_status(:success) }

    it 'そのコードのレビューがjsonで返ってくること' do
      get :show, params: { id: code.id }

      json = JSON.parse(response.body)
      expect(json.class).to eq(Hash)
      expect(json['review'].first['code_id']).to eq(review.code_id)
    end
  end

  describe 'POST #create' do
    context 'ログインしていない場合' do
      subject { post :create }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      include_context :login

      let(:code) { create(:code) }

      context 'エラーの場合' do
        let(:params) { { review: { code_id: code.id, line: 1, review: nil } } }

        it 'reviewは作成されない' do
          expect { post :create, params: params }.to change(Review, :count).by(0)
        end

        it 'status errorが返ってくる' do
          post :create, params: params
          expect(response).to be_json_error
        end
      end

      context '正常に保存された場合' do
        let(:params) { { review: { code_id: code.id, line: 1, review: Faker::Lorem.characters(number: 10) } } }

        it 'reviewを作成する' do
          expect { post :create, params: params }.to change(Review, :count).by(1)
        end

        it 'status successが返ってくる' do
          post :create, params: params
          expect(response).to be_json_success
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインしていない場合' do
      subject { put :update, params: { id: 1 } }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      include_context :login

      let!(:review) { create(:review, user: reviewer) }

      context 'ログインしているユーザー == コードの作成者' do
        let(:reviewer) { user }
        let(:new_review) { Faker::Lorem.characters(number: 10) }

        it 'updateされる' do
          put :update, params: { id: review.id, review: new_review }
          review.reload
          expect(review.review).to eq(new_review)
        end
      end

      context 'ログインしているユーザー != コードの作成者' do
        let(:reviewer) { create(:user) }

        it 'エラーになる' do
          put :update, params: { id: review.id }
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
      include_context :login

      let!(:review) { create(:review, user: reviewer) }

      context 'ログインしているユーザー != レビューの作成者' do
        let(:reviewer) { create(:user) }

        it 'エラーになる' do
          delete :destroy, params: { id: review.id }
          expect(response).to be_json_error
        end
      end

      context 'ログインしているユーザー == レビューの作成者' do
        let(:reviewer) { user }

        it 'reviewが削除される' do
          expect { delete :destroy, params: { id: review.id } }.to change(Review, :count).by(-1)
        end

        context 'review.idが見つからない場合' do
          it 'エラーになる' do
            delete :destroy, params: { id: 1 }
            expect(response).to be_json_error
          end
        end
      end
    end
  end
end

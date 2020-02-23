# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
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
      let(:user) { create(:user, :with_icon) }
      let(:code) { create(:code) }
      before { sign_in user }

      context 'エラーの場合' do
        let(:params) { { review: { code_id: code.id, line: 1, review: nil } } }

        it 'reviewは作成されない' do
          expect { post :create, params: params }.to change(Review, :count).by(0)
        end

        it 'status errorが返ってくる' do
          post :create, params: params
          body = JSON.parse(response.body)
          expect(body['status']).to eq('error')
        end
      end

      context '正常に保存された場合' do
        let(:params) { { review: { code_id: code.id, line: 1, review: Faker::Lorem.characters(number: 10) } } }

        it 'reviewを作成する' do
          expect { post :create, params: params }.to change(Review, :count).by(1)
        end

        it 'status successが返ってくる' do
          post :create, params: params
          body = JSON.parse(response.body)
          expect(body['status']).to eq('success')
        end
      end
    end
  end
end

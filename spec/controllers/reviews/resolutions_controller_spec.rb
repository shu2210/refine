# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reviews::ResolutionsController, type: :controller do
  describe 'PUT #update' do
    context 'ログインしていない場合' do
      subject { put :update, params: { id: 1 } }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let(:user) { create(:user) }

      before { sign_in user }

      context '成功した場合' do
        let(:review) { create(:review, user: user) }

        it 'reviewのresolvedをtrueにする' do
          put :update, params: { id: review.id }
          review.reload
          expect(review.resolved).to eq(true)
        end

        it 'successが返る' do
          put :update, params: { id: review.id }
          expect(response).to be_json_success
        end
      end

      context 'current_user != commentの作成者の場合' do
        let(:reviewer) { create(:user) }
        let(:review) { create(:review, user: reviewer) }

        it 'errorが返る' do
          put :update, params: { id: review.id }
          expect(response).to be_json_error
        end
      end

      context '失敗した場合' do
        it 'errorが返る' do
          put :update, params: { id: 1 }
          expect(response).to be_json_error
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::ResolutionsController, type: :controller do
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
        let(:comment) { create(:comment, user: user) }

        context 'resolveにtrueを渡した場合' do
          it 'reviewのresolvedをtrueにする' do
            put :update, params: { id: comment.id, resolve: true }
            comment.reload
            expect(comment.resolved).to eq(true)
          end
        end

        context 'resolveにfalseを渡した場合' do
          it 'reviewのresolvedをfalseにする' do
            put :update, params: { id: comment.id, resolve: false }
            comment.reload
            expect(comment.resolved).to eq(false)
          end
        end

        it 'successが返る' do
          put :update, params: { id: comment.id }
          expect(response).to be_json_success
        end
      end

      context 'current_user != commentの作成者の場合' do
        let(:commenter) { create(:user) }
        let(:comment) { create(:comment, user: commenter) }

        it 'errorが返る' do
          put :update, params: { id: comment.id }
          expect(response).to be_json_error
        end
      end

      context '失敗した場合' do
        context '存在しないidを渡した場合' do
          it 'エラーになる' do
            put :update, params: { id: 1 }
            expect(response).to be_json_error
          end
        end

        context 'resolveにtrue, false以外を渡した場合' do
          let(:comment) { create(:comment) }

          it 'エラーになる' do
            put :update, params: { id: comment.id, resolve: 'test' }
            expect(response).to be_json_error
          end
        end
      end
    end
  end
end

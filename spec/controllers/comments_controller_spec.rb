# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  shared_context :login do
    let(:user) { create(:user) }
    before { sign_in user }
  end

  describe 'GET #show' do
    let!(:review) { create(:review) }
    let!(:comment) { create(:comment, review: review) }

    it 'reviewに紐づくcommentsのjsonが返ってくる' do
      get :show, params: { id: review.id }
      comments = JSON.parse(response.body)['comments']
      expect(comments.count).to eq(1)
      expect(comments.last['id']).to eq(comment.id)
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

      let!(:review) { create(:review) }

      context 'エラーがある場合' do
        let!(:params) { { comments: { comment: '', review_id: review.id } } }

        it 'status = errorが返る' do
          post :create, params: params
          expect(response).to be_json_error
        end

        it 'commentsのレコードは作成されない' do
          expect { post :create, params: params }.to change(Comment, :count).by(0)
        end
      end

      context 'エラーがない場合' do
        let!(:params) { { comments: { comment: 'test', review_id: review.id } } }

        it 'status = successが返る' do
          post :create, params: params
          expect(response).to be_json_success
        end

        it 'commentsのレコードを作成する' do
          expect { post :create, params: params }.to change(Comment, :count).by(1)
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

      let!(:comment) { create(:comment, user: commenter) }

      context 'commentの作成者 != 更新者の場合' do
        let!(:commenter) { build(:user) }

        it 'エラーが返る' do
          put :update, params: { id: comment.id }
          expect(response).to be_json_error
        end
      end

      context 'commentの作成者 == 更新者の場合' do
        let!(:commenter) { user }

        context 'commentが空の場合' do
          it 'エラーが返る' do
            put :update, params: { id: comment.id, comment: '' }
            expect(response).to be_json_error
          end
        end

        context '成功の場合' do
          it 'commentが更新される' do
            put :update, params: { id: comment.id, comment: 'updated' }
            comment.reload
            expect(comment.comment).to eq('updated')
          end
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

      let!(:comment) { create(:comment) }

      context '存在するidが渡された場合' do
        it 'commentが削除される' do
          expect { delete :destroy, params: { id: comment.id } }.to change(Comment, :count).by(-1)
        end
      end

      context '存在しないidが渡された場合' do
        it 'errorが返る' do
          delete :destroy, params: { id: comment.id + 1 }
          expect(response).to be_json_error
        end
      end
    end
  end
end

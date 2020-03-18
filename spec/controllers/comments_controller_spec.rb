# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  shared_context :login do
    let(:user) { create(:user) }
    before { sign_in user }
  end

  describe 'GET #index' do
    context 'ログインしていない場合' do
      subject { get :index }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      include_context :login

      let!(:review) { create(:review) }
      let!(:comment) { create(:comment) }

      it 'commentsのjsonが返ってくる' do
        get :index
        comments = JSON.parse(response.body)['comments']
        expect(comments.count).to eq(1)
        expect(comments.last['id']).to eq(comment.id)
      end
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
          status = JSON.parse(response.body)['status']
          expect(status).to eq('error')
        end

        it 'commentsのレコードは作成されない' do
          expect { post :create, params: params }.to change(Comment, :count).by(0)
        end
      end

      context 'エラーがない場合' do
        let!(:params) { { comments: { comment: 'test', review_id: review.id } } }

        it 'status = successが返る' do
          post :create, params: params
          status = JSON.parse(response.body)['status']
          expect(status).to eq('success')
        end

        it 'commentsのレコードを作成する' do
          expect { post :create, params: params }.to change(Comment, :count).by(1)
        end
      end
    end
  end
end

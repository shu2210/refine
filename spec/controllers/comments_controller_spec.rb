# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    context 'ログインしていない場合' do
      subject { post :create }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      context 'エラーがある場合' do
        it 'エラーになる'
      end

      context 'エラーがない場合' do
        it 'commentsのレコードを作成する'
      end
    end
  end
end

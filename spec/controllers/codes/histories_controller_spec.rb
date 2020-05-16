# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Codes::HistoriesController, type: :controller do
  describe 'GET #show' do
    let(:user_code) { create(:user_code) }

    subject { get :show, params: { id: user_code.id } }

    context 'ログインしていない場合' do
      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      before { sign_in_user }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:show) }
    end
  end
end

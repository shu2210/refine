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
end

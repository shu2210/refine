# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodesController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template(:index) }
  end

  describe 'GET #new' do
    context 'ログインしていない場合' do
      subject { get :new }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      before { sign_in_user }

      subject { get :new }

      it { is_expected.to have_http_status(:ok) }
      it { is_expected.to render_template(:new) }
    end
  end

  describe 'POST #create' do
    before { sign_in_user }

    context '正常な場合' do
      let(:param) { { code: { title: 'test', description: 'test', language_id: 1, code: 'test' }, tags: %w[Rails Ruby] } }
      it 'codeが作成される' do
        expect { post :create, params: param }.to change(Code, :count).by(1)
      end
    end

    context 'エラーの場合' do
      let(:param) { { code: { description: 'test', language_id: 1, code: 'test' }, tags: %w[Rails Ruby] } }

      it 'newがrenderされる' do
        post :create, params: param
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    before { create(:code, id: id) }
    let(:id) { Faker::Number.number(digits: 1) }

    subject { get :show, params: { id: id } }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template(:show) }
  end
end

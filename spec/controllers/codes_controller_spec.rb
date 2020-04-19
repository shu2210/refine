# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodesController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template(:index) }
  end

  describe 'GET #show' do
    let(:user_code) { create(:user_code) }

    subject { get :show, params: { id: user_code.id } }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template(:show) }
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
      let!(:language) { Language.first }
      let!(:params) { { user_code: { title: 'test', description: 'test' }, code: [{ language_id: language.id, code: 'test' }], tags: %w[Rails Ruby] } }

      it 'user_codeが作成される' do
        expect { post :create, params: params }.to change(UserCode, :count).by(1)
      end

      it 'codeが作成される' do
        expect { post :create, params: params }.to change(Code, :count).by(1)
      end
    end

    context 'エラーの場合' do
      let!(:language) { Language.first }
      let!(:params) { { user_code: { description: 'test' }, code: [{ language_id: language.id, code: 'test' }], tags: %w[Rails Ruby] } }

      it 'newがrenderされる' do
        post :create, params: params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしていない場合' do
      subject { get :edit, params: { id: 1 } }

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to('/users/sign_in') }
    end

    context 'ログインしている場合' do
      let!(:user) { create(:user) }

      before { sign_in user }

      context 'current_user != 作成者' do
        let!(:user_code) { create(:user_code, user: build(:user)) }

        it 'Forbiddenになる' do
          get :edit, params: { id: user_code.id }
          expect(response).to render_template('errors/forbidden')
        end
      end

      context 'current_user == 作成者' do
        let!(:user_code) { create(:user_code, user: user) }

        subject { get :edit, params: { id: user_code.id } }

        it { is_expected.to have_http_status(:ok) }
        it { is_expected.to render_template(:edit) }
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
      let!(:user) { create(:user) }

      before { sign_in user }

      context 'current_user != 作成者' do
        let!(:coder) { build(:user) }
        let!(:user_code) { create(:user_code, user: coder) }

        it 'Forbiddenになる' do
          put :update, params: { id: user_code.id }
          expect(response).to render_template('errors/forbidden')
        end
      end

      context 'current_user == 作成者' do
        let!(:language) { Language.first }

        context 'エラーがある場合' do
          let!(:user_code) { create(:user_code, title: '', user: user) }
          let!(:params) do
            {
              id: user_code.id,
              user_code: {
                title: :test,
                description: nil
              },
              code: [{ language_id: language.id, code: :test }],
              tags: %w[tag1 tag2]
            }
          end

          it 'レコードが追加されない' do
            expect { put :update, params: params }.not_to change(UserCode, :count)
          end

          it 'editがrenderされる' do
            put :update, params: params
            expect(response).to render_template(:edit)
          end
        end

        context '正常の場合' do
          let!(:code) { build(:code) }
          let!(:user_code) { create(:user_code, codes: [code], user: user) }
          let!(:params) do
            {
              id: user_code.id,
              user_code: {
                title: :test,
                description: :test
              },
              code: [{ language_id: language.id, code: :test }],
              tags: %w[tag1 tag2]
            }
          end

          it 'レコードが追加される' do
            expect { put :update, params: params }.to change(UserCode, :count).by(1)
          end

          it 'indexにリダイレクトされる' do
            put :update, params: params
            expect(response).to redirect_to(root_path)
          end
        end
      end
    end
  end
end

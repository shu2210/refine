# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodesController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template(:index) }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: Faker::Number.number(digits: 1) } }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template(:show) }
  end
end

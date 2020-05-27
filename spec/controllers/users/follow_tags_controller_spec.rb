# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::FollowTagsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template(:new) }
  end
end

# frozen_string_literal: true

module TestHelper
  def sign_in_user
    user = create(:user)
    sign_in user
  end
end

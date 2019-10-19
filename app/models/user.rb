# frozen_string_literal: true

require_relative 'concerns/flash_validatable'

class User < ApplicationRecord
  include FlashValidatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[github google]

  flash_validation :reset_password_token

  before_save do
    self.name = email.match(/.*(?=@)/).to_s if new_record?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end
end

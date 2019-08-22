# frozen_string_literal: true

require_relative 'concerns/flash_validatable'

class User < ApplicationRecord
  include FlashValidatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  flash_validation :reset_password_token
end

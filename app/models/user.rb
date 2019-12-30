# frozen_string_literal: true

require_relative 'concerns/flash_validatable'

class User < ApplicationRecord
  include FlashValidatable

  attr_accessor :current_password, :new_password, :new_password_confirmation

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[github google]

  flash_validation :reset_password_token

  has_many :codes
  has_many :code_likes
  has_many :code_dislikes

  validates :name, presence: true, on: :profile
  validates :description, length: { maximum: 255 }, on: :profile
  validates :current_password, presence: true, on: :change_password
  validates :new_password, presence: true, on: :change_password
  validates :new_password_confirmation, presence: true, on: :change_password

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

  def update_profile(user_params)
    assign_attributes(user_params)
    save(context: :profile)
  end

  def posted_codes
    Code.includes(:tags).where(user_id: id).order(created_at: :desc).limit(10)
  end

  def liked_codes
    code_ids = CodeLike.where(user_id: id).pluck(:code_id)
    Code.where(id: code_ids)
  end

  def reviewed_codes
    code_ids = Review.where(user_id: id).pluck(:code_id)
    Code.where(id: code_ids)
  end

  def change_password(user_params)
    assign_attributes(user_params)
    return false unless valid_password?(current_password)

    valid?(:change_password)
    reset_password(new_password, new_password_confirmation)
  end

  def sns_registration?
    provider.present?
  end
end

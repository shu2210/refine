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

  has_many :codes
  has_many :code_likes
  has_many :code_dislikes

  validates :name, presence: true, on: :profile
  validates :description, length: { maximum: 255 }, on: :profile

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
end

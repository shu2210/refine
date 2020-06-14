# frozen_string_literal: true

class User < ApplicationRecord
  include FlashValidatable

  attr_accessor :current_password, :new_password, :new_password_confirmation

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[github google]

  flash_validation :reset_password_token

  has_many :user_codes
  has_many :user_code_likes
  has_many :user_code_dislikes
  has_many :comments
  has_many :user_tags
  has_many :tags, through: :user_tags

  has_one_attached :icon

  validates :name, presence: true, on: :profile
  validates :description, length: { maximum: 255 }, on: :profile
  validates :tags, presence: true, on: :follow_tags

  with_options on: :change_password do
    validates :current_password, presence: true
    validates :new_password, presence: true
    validates :new_password_confirmation, presence: true
  end

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
    UserCode.includes(:tags).where(user_id: id).order(created_at: :desc).limit(10)
  end

  def liked_codes
    code_ids = UserCodeLike.where(user_id: id).pluck(:user_code_id)
    UserCode.where(id: code_ids)
  end

  def reviewed_codes
    code_ids = Review.where(user_id: id).pluck(:code_id).uniq
    Code.includes(:user_code).where(id: code_ids)&.map(&:user_code)
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

  def icon_url
    return unless icon&.attached?

    Rails.application.routes.url_helpers.rails_blob_path(icon, disposition: 'attachment', only_path: true)
  end

  def attributes
    hash = super
    hash['icon_url'] = icon_url
    hash
  end

  def follow_tags(tag_names)
    self.tags = tag_names.map do |name|
      Tag.find_or_create_by(name: name)
    end
    valid?(:follow_tags)
  end
end

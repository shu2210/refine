# frozen_string_literal: true

require_relative 'concerns/flash_validatable'

class UserCode < ApplicationRecord
  include FlashValidatable
  extend Enumerize

  DRAFT_LIMIT = 15

  belongs_to :user

  # NOTE: codesを一番上に持っていくと下書きをした時にtagが保存されない(unlessでvalidtionをスキップさせているせいか)
  has_many :user_code_tags, dependent: :destroy
  has_many :tags, through: :user_code_tags
  has_many :user_code_likes, dependent: :destroy
  has_many :user_code_dislikes, dependent: :destroy
  has_many :codes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }, on: %i[post draft]
  validates :description, presence: true, length: { maximum: 300 }, on: %i[post draft]

  validate :draft_count, on: %i[draft]

  flash_validation :base

  enumerize :status, in: %i[draft published closed]

  scope :latest, lambda {
    includes([{ codes: :language }, :tags, :user])
      .where(status: %i[published closed])
      .order(created_at: :desc)
      .limit(10)
  }
  # TODO: レビュー機能実装後作成
  scope :popular, lambda {
    includes([{ codes: :language }, :tags, :user])
      .where(status: %i[published closed])
      .order(created_at: :desc)
      .limit(10)
  }

  def likes
    user_code_likes.length
  end

  def liked?(user_id)
    code_like = user_code_likes.select { |like| like.user_id == user_id }
    code_like.present?
  end

  def dislikes
    user_code_dislikes.length
  end

  def disliked?(user_id)
    code_dislike = user_code_dislikes.select { |dislike| dislike.user_id == user_id }
    code_dislike.present?
  end

  def draft(tag_names)
    transaction do
      self.status = :draft
      create_tags(tag_names)
      save!(context: :draft)
    end
    true
  rescue StandardError => e
    logger.error e
    false
  end

  def post(tag_names)
    transaction do
      self.status = :published
      create_tags(tag_names)
      save!(context: :post)
    end
    true
  rescue StandardError => e
    logger.error e
    false
  end

  private

  def create_tags(tag_names)
    return if tag_names.blank?

    tag_names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      tags.push(tag)
    end
  end

  def draft_count
    count = UserCode.where(user_id: user_id, status: :draft).count
    errors.add(:base, :over_drafts_limit) if count > DRAFT_LIMIT
  end
end

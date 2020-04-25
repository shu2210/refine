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

  enumerize :status, in: %i[draft post closed]

  scope :latest, lambda {
    includes([{ codes: :language }, :tags, :user])
      .where(status: %i[post closed], active: true)
      .order(created_at: :desc)
      .limit(10)
  }

  scope :popular, lambda {
    joins(codes: :reviews)
      .where(status: %i[post closed], active: true)
      .group('user_codes.id')
      .order('count DESC')
      .select('user_codes.id', 'COUNT(*) AS count')
      .limit(5)
  }

  def self.drafts(user_id)
    where(
      active: true,
      user_id: user_id,
      status: :draft
    ).order(updated_at: :desc, id: :desc)
  end

  def self.histories(id)
    where(code_group_id: find(id).code_group_id)
  end

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
      create_tags(tag_names)
      create_code(:draft)
      self
    end
  rescue StandardError => e
    logger.error e
    false
  end

  def post(tag_names)
    transaction do
      create_tags(tag_names)
      create_code(:post)
      self
    end
  rescue StandardError => e
    logger.error e
    false
  end

  def update_version(id, tag_names, new_status)
    old_code = self.class.find(id)
    transaction do
      old_code.deactivate
      self.user = old_code.user
      self.status = new_status
      self.code_group_id = old_code.code_group_id
      self.active = true
      create_tags(tag_names)
      save!(context: new_status)
      self
    end
  rescue StandardError => e
    logger.error e
    false
  end

  def deactivate
    update!(active: false)
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

  def new_codes(new_user_code)
    codes.map do |code|
      code.user_code_id = new_user_code.id
      code
    end
  end

  def next_group_id
    group_id = UserCode.where(user_id: user_id).maximum(:code_group_id)
    group_id.to_i + 1
  end

  def create_code(status)
    self.status = status
    self.code_group_id = next_group_id
    self.active = true
    save!(context: status)
  end
end

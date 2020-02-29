# frozen_string_literal: true

class UserCode < ApplicationRecord
  extend Enumerize

  belongs_to :user

  has_many :codes
  has_many :user_code_tags
  has_many :tags, through: :user_code_tags
  has_many :user_code_likes
  has_many :user_code_dislikes

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 300 }

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
    code_dislikes.length
  end

  def disliked?(user_id)
    code_dislike = code_dislikes.select { |dislike| dislike.user_id == user_id }
    code_dislike.present?
  end

  def draft
    self.status = :draft
    save(validate: false)
  end

  def post(tag_names)
    transaction do
      self.status = :published
      save || create_tags(tag_names)
    end
  end

  private

  def create_tags(tag_names)
    tag_names&.each do |name|
      tag = Tag.find_or_create_by(name: name)
      code_tag = UserCodeTag.new
      code_tag.user_code = self
      code_tag.tag = tag
      code_tag.save
    end
  end
end

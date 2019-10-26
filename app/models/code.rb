# frozen_string_literal: true

class Code < ApplicationRecord
  belongs_to :user
  belongs_to :language

  has_many :code_tags
  has_many :tags, through: :code_tags
  has_many :code_likes
  has_many :code_dislikes

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :code, presence: true

  enum status: %i[draft published closed]

  scope :latest, lambda {
    includes(:tags)
      .includes(:language)
      .includes(:user)
      .where(status: %i[published closed])
      .order(created_at: :desc)
      .limit(10)
  }
  # TODO: レビュー機能実装後作成
  scope :popular, lambda {
    includes(:tags)
      .includes(:language)
      .includes(:user)
      .where(status: %i[published closed])
      .order(created_at: :desc)
      .limit(10)
  }

  def post(user, tag_names)
    transaction do
      self.status = :published
      self.user = user
      save && create_tags(tag_names)
    end
  end

  def draft
    self.status = :draft
    save(validate: false)
  end

  def likes
    code_likes.length
  end

  def liked?(user_id)
    code_like = code_likes.select { |like| like.user_id == user_id }
    code_like.present?
  end

  def dislikes
    code_dislikes.length
  end

  def disliked?(user_id)
    code_dislike = code_dislikes.select { |dislike| dislike.user_id == user_id }
    code_dislike.present?
  end

  private

  def create_tags(tag_names)
    tag_names.each do |name|
      tag = Tag.find_or_create_by(name: name)
      code_tags.create(tag_id: tag.id)
    end
  end
end

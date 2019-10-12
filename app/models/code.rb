# frozen_string_literal: true

class Code < ApplicationRecord
  belongs_to :user

  has_one :language

  has_many :code_tags
  has_many :tags, through: :code_tags

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :code, presence: true

  enum status: %i[draft published closed]

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

  private

  def create_tags(tag_names)
    tag_names.each do |name|
      tag = Tag.find_or_create_by(name: name)
      code_tags.create(tag_id: tag.id)
    end
  end
end

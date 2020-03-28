# frozen_string_literal: true

require 'active_support/concern'

module ArrayParsable
  extend ActiveSupport::Concern

  class_methods do
    def array_with_one(model)
      comments = includes(model).order(created_at: :desc)
      comments.map do |comment|
        comment.array_with_one(model)
      end
    end
  end

  def array_with_one(model)
    hash_with_user = attributes_with(model.to_sym)
    hash_with_user
  end

  private

  def attributes_with(model)
    attributes = self.attributes
    attributes[model] = send(model).attributes
    attributes.with_indifferent_access
  end
end

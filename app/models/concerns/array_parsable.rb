# frozen_string_literal: true

require 'active_support/concern'

module ArrayParsable
  extend ActiveSupport::Concern

  class_methods do
    def array_with(*associations)
      records = includes(associations)
      records.map do |record|
        hash = record.attributes
        associations.each do |association|
          hash[association] = record.attributes_with(association)
        end
        hash.with_indifferent_access
      end
    end
  end

  def array_with(*associations)
    hash = attributes
    associations.each do |association|
      hash[association] = attributes_with(association)
    end
    hash.with_indifferent_access
  end

  def attributes_with(association)
    if association.to_s == association.to_s.pluralize
      send(association).map(&:attributes)
    else
      send(association).attributes
    end
  end
end

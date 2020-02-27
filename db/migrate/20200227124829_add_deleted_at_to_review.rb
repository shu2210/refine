# frozen_string_literal: true

class AddDeletedAtToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :deleted_at, :datetime
    add_index :reviews, :deleted_at
  end
end

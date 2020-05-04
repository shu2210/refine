# frozen_string_literal: true

class AddResolveColumnToCommentAndReview < ActiveRecord::Migration[5.2]
  def up
    add_column :reviews, :resolved, :boolean, after: :review, default: false
    add_column :comments, :resolved, :boolean, after: :comment, default: false
  end

  def down
    remove_column :reviews, :resolved, :boolean
    remove_column :comments, :resolved, :boolean
  end
end

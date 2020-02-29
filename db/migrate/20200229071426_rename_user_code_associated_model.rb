# frozen_string_literal: true

class RenameUserCodeAssociatedModel < ActiveRecord::Migration[5.2]
  def change
    rename_table :code_tags, :user_code_tags
    rename_table :code_likes, :user_code_likes
    rename_table :code_dislikes, :user_code_dislikes
  end
end

# frozen_string_literal: true

class RenameUserCodeAssociatedModel < ActiveRecord::Migration[5.2]
  def change
    rename_table :code_tags, :user_code_tags
    rename_table :code_likes, :user_code_likes
    rename_table :code_dislikes, :user_code_dislikes
    rename_column :user_code_likes, :code_id, :user_code_id
    rename_column :user_code_dislikes, :code_id, :user_code_id
  end
end

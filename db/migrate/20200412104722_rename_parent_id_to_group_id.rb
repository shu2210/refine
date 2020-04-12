# frozen_string_literal: true

class RenameParentIdToGroupId < ActiveRecord::Migration[5.2]
  def up
    rename_column :user_codes, :parent_id, :code_group_id
  end

  def down
    rename_column :user_code_likes, :code_group_id, :parent_id
  end
end

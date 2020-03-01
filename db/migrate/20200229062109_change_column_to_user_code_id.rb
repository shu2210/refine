# frozen_string_literal: true

class ChangeColumnToUserCodeId < ActiveRecord::Migration[5.2]
  def up
    remove_column :code_tags, :code_id, :integer
    add_column :code_tags, :user_code_id, :integer, after: :id
  end

  def down
    add_column :code_tags, :code_id, :integer, after: :id
    remove_column :code_tags, :user_code_id, :integer
  end
end

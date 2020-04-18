# frozen_string_literal: true

class AddHistoryColumnToUserCodes < ActiveRecord::Migration[5.2]
  def up
    add_column :user_codes, :parent_id, :integer, after: :user_id
    add_column :user_codes, :version, :integer, after: :parent_id
  end

  def down
    remove_column :user_codes, :parent_id
    remove_column :user_codes, :version
  end
end

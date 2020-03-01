# frozen_string_literal: true

class ChangeGroupColumnToCodes < ActiveRecord::Migration[5.2]
  def up
    remove_column :codes, :user_id, :integer
    remove_column :codes, :status, :string
    remove_column :codes, :title, :string
    remove_column :codes, :description, :string
    add_column :codes, :user_code_id, :integer, after: :id
  end

  def down
    add_column :codes, :user_id, :integer
    add_column :codes, :status, :string
    add_column :codes, :title, :string
    add_column :codes, :description, :string
    remove_column :codes, :user_code_id, :integer
  end
end

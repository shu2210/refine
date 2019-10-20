# frozen_string_literal: true

class AddColumnToCode < ActiveRecord::Migration[5.2]
  def change
    add_column :codes, :title, :string, after: :user_id
    add_column :codes, :description, :string, after: :title
    add_column :codes, :status, :integer, after: :user_id
  end
end

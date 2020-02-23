# frozen_string_literal: true

class ChangeStatusOfCodeToString < ActiveRecord::Migration[5.2]
  def change
    remove_column :codes, :status
    add_column :codes, :status, :string, after: :user_id
  end
end

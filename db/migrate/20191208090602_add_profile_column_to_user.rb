# frozen_string_literal: true

class AddProfileColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :description, :string, after: :email
  end
end

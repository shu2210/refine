# frozen_string_literal: true

class CreateUserCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_codes do |t|
      t.integer :user_id, comment: 'ユーザーID'
      t.string :status, comment: 'ステータス'
      t.string :title, comment: 'タイトル'
      t.string :description, comment: '説明'
      t.timestamps
    end
  end
end

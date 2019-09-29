# frozen_string_literal: true

class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.integer :language_id, comment: '言語ID'
      t.integer :user_id, comment: 'ユーザーID'
      t.text :code, comment: 'コード'
      t.timestamps
    end
  end
end

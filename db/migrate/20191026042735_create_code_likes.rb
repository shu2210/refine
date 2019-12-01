# frozen_string_literal: true

class CreateCodeLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :code_likes do |t|
      t.integer :user_id
      t.integer :code_id
      t.timestamps
    end
  end
end

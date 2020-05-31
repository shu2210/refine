# frozen_string_literal: true

class CreateUserTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tags do |t|
      t.integer :user_id
      t.integer :tag_id
      t.timestamps
    end
  end
end

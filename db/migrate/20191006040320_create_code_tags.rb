# frozen_string_literal: true

class CreateCodeTags < ActiveRecord::Migration[5.2]
  def change
    create_table :code_tags do |t|
      t.integer :code_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
  end
end

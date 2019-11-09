# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :code_id
      t.integer :line
      t.text :review
      t.timestamps
    end
  end
end

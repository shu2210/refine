# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :mode, comment: 'モード'
      t.string :name, comment: '言語名'
      t.timestamps
    end
  end
end

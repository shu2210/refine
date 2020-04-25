# frozen_string_literal: true

class AddActiveToUserCode < ActiveRecord::Migration[5.2]
  def up
    add_column :user_codes, :active, :boolean, default: false, after: :description
  end

  def down
    remove_column :user_codes, :active
  end
end

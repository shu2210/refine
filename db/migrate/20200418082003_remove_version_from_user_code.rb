# frozen_string_literal: true

class RemoveVersionFromUserCode < ActiveRecord::Migration[5.2]
  def up
    remove_column :user_codes, :version
  end

  def down
    add_column :user_codes, :version, :integer, after: :parent_id
  end
end

# frozen_string_literal: true

# Add admin to users
class AddAdminToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean
  end
end

# frozen_string_literal: true

# Migration for AddPasswordDigestToUsers
class AddPasswordDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
  end
end

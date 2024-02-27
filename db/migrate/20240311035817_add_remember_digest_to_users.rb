# frozen_string_literal: true

# Add remember digests to users
class AddRememberDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :remember_digest, :string
  end
end

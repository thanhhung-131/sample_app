# frozen_string_literal: true

# Migration to create products table
class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name

      t.timestamps
    end
  end
end

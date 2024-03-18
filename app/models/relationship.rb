# frozen_string_literal: true

# Relationship model
class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
end

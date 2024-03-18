# frozen_string_literal: true

# Micropost model
class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: Settings.size_500x500
  end

  validates :content, presence: true, length: { maximum: Settings.digit_140 }
  validates :image,
            content_type: {
              in: %w[image/jpeg image/gif image/png],
              message: I18n.t("microposts.image.must_be_valid")
            },
            size: {
              less_than: Settings.size_5MB,
              message: I18n.t("microposts.image.max_size")
            }

  scope :newest, -> { order(created_at: :desc) }
end

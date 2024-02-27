# frozen_string_literal: true

# User model
class User < ApplicationRecord
  VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  before_save :downcase_email

  validates :name, presence: true, length: { maximum: Settings.digit_50 }
  validates :email, presence: true, length: { maximum: Settings.digit_255 },
                    format: { with: VALIDATE_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: Settings.digit_6 }
  validates :gender, presence: true
  validates :birthday, presence: true
  validate :birthday_within_last_100_years

  private

  def downcase_email
    email.downcase!
  end

  def birthday_within_last_100_years
    return unless birthday < Settings.HUNDRED_YEARS_OLD.years.ago.to_date

    errors.add(:birthday, :birthday_within_last_100_years)
  end
end

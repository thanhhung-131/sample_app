# frozen_string_literal: true

# User model
class User < ApplicationRecord
  attr_accessor :remember_token

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

  class << self
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_columns remember_digest: User.digest(remember_token)
  end

  def forget
    update_columns remember_digest: nil
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  private

  def downcase_email
    email.downcase!
  end

  def birthday_within_last_100_years
    return unless birthday < Settings.HUNDRED_YEARS_OLD.years.ago.to_date

    errors.add(:birthday, :birthday_within_last_100_years)
  end
end

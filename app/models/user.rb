# frozen_string_literal: true

# User model
class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: { maximum: Settings.digit_50 }
  validates :email, presence: true, length: { maximum: Settings.digit_255 },
                    format: { with: VALIDATE_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: Settings.digit_6 }, allow_nil: true
  validates :gender, presence: true
  validates :birthday, presence: true
  validate :birthday_within_last_100_years, if: -> { birthday.present? }

  scope :sort_by_name, -> { order(:name) }

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def remember
    self.remember_token = User.new_token
    update_columns remember_digest: User.digest(remember_token)
  end

  def forget
    update_columns remember_digest: nil
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def authenticated?(attribute, token)
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def birthday_within_last_100_years
    errors.add(:birthday, :birthday_within_last_100_years) if birthday < Settings.HUNDRED_YEARS.years.ago.to_date
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t("users.mailer.password_reset_expired")
    redirect_to new_password_reset_url
  end
end

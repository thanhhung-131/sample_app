# frozen_string_literal: true

# User mailer
class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: t("users.mailer.activation")
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: t("users.mailer.password_reset")
  end
end

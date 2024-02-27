# frozen_string_literal: true

# PasswordResetsController
class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: %i(create edit update)
  before_action :check_password_presence, only: :update

  def new; end

  def create
    if @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("users.mailer.sent_password_reset")
      redirect_to root_url
    else
      flash.now[:danger] = t("users.mailer.password_reset_failed")
      render :new
    end
  end

  def update
    if @user.update(user_params)
      log_in @user
      @user.update_columns(reset_digest: nil)
      flash[:success] = t("users.mailer.password_reset_success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by(email: params.dig(:password_reset, :email)&.downcase || params[:email])
    return if @user

    flash[:danger] = t("layouts.messages.user_not_found")
    redirect_to root_url
  end

  def valid_user
    return if @user.activated

    flash[:danger] = t("users.mailer.not_activated")
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t("users.mailer.password_reset_expired")
    redirect_to new_password_reset_url
  end

  def check_password_presence
    return if user_params[:password].present?

    @user.errors.add(:password, :blank)
    render :edit, status: :unprocessable_entity
  end
end

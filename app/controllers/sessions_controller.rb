# frozen_string_literal: true

# Sessions controller
class SessionsController < ApplicationController
  before_action :load_user, :check_authenticate, only: :create

  def new; end

  def create
    if @user.activated?
      reset_session
      params.dig(:session, :remember_me) == "1" ? remember(@user) : forget(@user)
      log_in @user
      redirect_back_or @user
    else
      flash[:warning] = t("users.mailer.not_activated")
      redirect_to root_url, status: :see_other
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return if @user

    flash.now[:danger] = t("layouts.messages.user_not_found")
    render :new
  end

  def check_authenticate
    return if @user.authenticate(params.dig(:session, :password))

    flash.now[:danger] = t("layouts.messages.invalid_email_password_combination")
    render :new
  end
end

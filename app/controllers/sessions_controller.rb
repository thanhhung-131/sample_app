# frozen_string_literal: true

# SessionsController
class SessionsController < ApplicationController
  def new; end

  def load_user
    @user = User.find_by(email: params.dig(:session, :email)&.downcase)
    return if @user

    flash.now[:danger] = t("layouts.messages.user_not_found")
    render :new, status: :unprocessable_entity
  end

  def create
    load_user
    return if performed? # Check if render or redirect has already been called

    if @user&.authenticate params.dig(:session, :password)
      reset_session
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = t("layouts.messages.invalid_email_password_combination")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end

# frozen_string_literal: true

# AccountActivationsController
class AccountActivationsController < ApplicationController
  before_action :load_user, :check_activation, only: :edit

  def edit
    if @user.activate
      log_in(@user)
      flash[:success] = t("users.mailer.activated")
      redirect_to(@user)
    else
      flash[:danger] = t("users.mailer.invalid_activation_link")
      redirect_to(root_path)
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash.now[:danger] = t("layouts.messages.user_not_found")
    render :new
  end

  def check_activation
    return unless @user.activated? && !@user.authenticate?(:activation, params[:id])

    flash[:danger] = t("layouts.messages.invalid_activation_link")
    redirect_to root_url
  end
end

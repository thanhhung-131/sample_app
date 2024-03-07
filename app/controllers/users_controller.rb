# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t("user_not_found")
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = I18n.t("layouts.messages.sign_up_success")
      redirect_to @user
    else
      flash[:error] = I18n.t("layouts.messages.sign_up_error")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :birthday, :gender, :password, :password_confirmation
  end
end

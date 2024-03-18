# frozen_string_literal: true

# Users controller
class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show
    @page, @microposts = pagy @user.microposts, items: Settings.page_10
  end

  def new
    @user = User.new
  end

  def index
    @pagy, @users = pagy User.all, items: Settings.page_10
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = I18n.t("users.mailer.information")
      redirect_to root_path, status: :see_other
    else
      flash[:error] = I18n.t("layouts.messages.error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = I18n.t("layouts.messages.updated_success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = I18n.t("layouts.messages.deleted_success")
    else
      flash[:error] = I18n.t("layouts.messages.deleted_error")
    end
    redirect_to users_path
  end

  private

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = I18n.t("layouts.messages.user_not_found")
    redirect_to root_path
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = I18n.t("layouts.messages.not_authorized")
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :birthday, :gender, :password, :password_confirmation
  end
end

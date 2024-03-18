# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Pagy::Backend

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = I18n.t("layouts.messages.please_log_in")
    redirect_to login_path
  end
end

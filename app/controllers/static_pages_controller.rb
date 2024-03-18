# frozen_string_literal: true

# StaticPagesController is a controller for static pages.
class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy(current_user.feed.newest, items: Settings.page_10)
  end

  def help; end

  def about; end

  def contact; end
end

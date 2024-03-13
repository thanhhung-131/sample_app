# frozen_string_literal: true

# Application helper
module ApplicationHelper
  include Pagy::Frontend

  def full_title(page_title = "")
    base_title = t("helpers.page_title")
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end

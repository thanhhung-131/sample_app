# frozen_string_literal: true

# Application helper
module ApplicationHelper
  def full_title(page_title = "")
    base_title = t(:ruby_tutorial, project_name: t(:name).titlecase)
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end

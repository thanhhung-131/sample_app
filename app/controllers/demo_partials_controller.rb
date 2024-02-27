# frozen_string_literal: true

# Class DemoPartialsController is a controller for managing demo partials.
class DemoPartialsController < ApplicationController
  def new
    @zone = t(:zone_new)
    @date = Date.today
  end

  def edit
    @zone = t(:zone_edit)
    @date = Date.today - 4
  end
end

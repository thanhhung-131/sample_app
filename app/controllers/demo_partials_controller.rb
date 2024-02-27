# frozen_string_literal: true

# Class DemoPartialsController is a controller for managing demo partials.
class DemoPartialsController < ApplicationController
  def new
    @zone = 'Zone New Action'
    @date = Date.today
  end

  def edit
    @zone = 'Zone Edit Action'
    @date = Date.today - 4
  end
end

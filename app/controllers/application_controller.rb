# frozen_string_literal: true

class ApplicationController < ActionController::API
  include PermitableParams
  include ErrorRescues
end

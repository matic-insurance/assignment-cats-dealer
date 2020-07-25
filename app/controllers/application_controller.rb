class ApplicationController < ActionController::Base
  include ApiConcern

  protect_from_forgery with: :exception
end

# frozen_string_literal: true

module Errors
  # InvalidCatError is raised when a Cat object is initialized with invalid or missing attributes.
  #
  # This custom error class is used to signal that the data for a cat is incomplete or incorrect,
  # such as when required attributes (e.g., name, price, location, or image) are blank or nil.
  #
  # Example usage:
  #   raise Errors::InvalidCatError, "Name is missing" if cat_name.blank?
  class InvalidCatError < ::StandardError; end
end

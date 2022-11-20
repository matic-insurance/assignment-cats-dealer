# frozen_string_literal: true

class CatsFilter
  extend Dry::Initializer

  option :location, proc(&:to_s), optional: true
  option :type, proc(&:to_s), optional: true

  def result
    result = CatsFetchService.call

    result = result.select { |cat| cat.location.downcase == location.downcase } if location.present?
    result = result.select { |cat| cat.type.downcase == type.downcase } if type.present?
    result.sort_by(&:price)
  end
end

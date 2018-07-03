require_relative 'requests'

class CatsAnalyzerService
  def initialize(data)
    @data = data
  end

  def all(type, location)
    select_by @data, type, location
  end

  private

  def select_by(data, type, location)
    data.select { |cat| cat['name'] == type && cat['location'] == location }
  end
end

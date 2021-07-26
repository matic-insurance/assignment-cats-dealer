class CatsFetcher
  SERVICES = [
    CatsUnlimitedAdapter,
    HappyCatsAdapter
  ].freeze

  def call
    SERVICES.flat_map do |service|
      retryable(on: ApplicationAdapter::ServiceError) { service.new.call }
    end
  end

  def retryable(tries: 3, on: StandardError, interval: 1)
    (1..tries).each do |attempt|
      return yield
    rescue on => _exception
      sleep(interval) and interval *= 2 if interval > 0
    end
  end
end

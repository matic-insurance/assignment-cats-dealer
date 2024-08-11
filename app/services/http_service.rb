# frozen_string_literal: true

require 'rest-client'

# HttpService provides a robust mechanism for making HTTP GET requests with
# built-in retry logic. This service is designed to handle transient network
# errors by retrying the request multiple times before failing.
#
# The service handles specific RestClient exceptions such as timeouts and
# open timeouts, and logs any issues encountered during the request process.
#
# Example usage:
#   service = HttpService.new
#   response = service.get('https://example.com/api/resource')
#
# The number of retries and the delay between retries are configurable through
# the MAX_RETRIES and RETRY_DELAY constants.
class HttpService
  MAX_RETRIES = 3
  RETRY_DELAY = 2 # seconds

  def get(url)
    with_retries do
      response = RestClient.get(url)
      handle_response(response)
    end
  end

  private

  def with_retries
    retries = 0

    begin
      yield
    rescue RestClient::Exceptions::Timeout, RestClient::Exceptions::OpenTimeout => e
      retries += 1
      log_retry_warning(e, retries)

      if retries < MAX_RETRIES
        sleep RETRY_DELAY * retries
        retry
      end

      log_max_retries_error(e)
      nil
    rescue StandardError => e
      log_standard_error(e)
      nil
    end
  end

  def handle_response(response)
    return response.body if response.code == 200

    raise RestClient::ExceptionWithResponse.new(response)
  end

  def log_retry_warning(error, retries)
    Rails.logger.error("Failed fetching data: #{error.message}, retrying (#{retries}/#{MAX_RETRIES})")
  end

  def log_max_retries_error(error)
    Rails.logger.error("Failed to fetch data after #{MAX_RETRIES} attempts: #{error.message}")
  end

  def log_standard_error(error)
    Rails.logger.error("Failed fetching data: #{error.message}")
  end
end

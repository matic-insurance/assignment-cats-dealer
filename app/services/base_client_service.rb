# frozen_string_literal: true

class BaseClientService
  def call
    response = RestClient.get(url)

    format_response(response, shop_name)
  rescue StandardError => e
    Rails.logger.error "[#{self.class}]: ERROR - #{e.message}"
    []
  end

  private

  def url
    self.class::URL
  end

  def format_response(response, shop_name)
    raise NotImplementedError
  end

  def shop_name
    self.class.to_s.chomp('Service').titleize
  end
end

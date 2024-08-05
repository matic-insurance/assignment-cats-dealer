# frozen_string_literal: true

require 'rest-client'

class ShopConnector
  INVALID_SHOP_URL_MSG = 'Invalid shop URL'
  INVALID_RESPONSE_FORMAT_MSG = 'Invalid response format'
  VALID_RESPONSE_FORMATS = %i[json xml]
  class InvalidShopUrlError < StandardError; end
  class InvalidResponseFormatError < StandardError; end

  def initialize(api_url, response_format)
    @api_url = api_url
    @response_format = response_format
    validate_input_params!
  end

  def get_cats
    response = RestClient.get(api_url)
    { cats: parse_response(response.body) }.with_indifferent_access
  rescue RestClient::ExceptionWithResponse => e
    { error: e.response }
  end

  private
  attr_accessor :api_url, :response_format

  def parse_response(body)
    case response_format
    when :json
      Parser::JsonParser.parse(body)
    when :xml
      Parser::XmlParser.parse(body)
    else
      { error: 'Unsupported format' }
    end
  end

  def validate_input_params!
    raise InvalidShopUrlError, INVALID_SHOP_URL_MSG if api_url.blank?
    raise InvalidResponseFormatError, INVALID_RESPONSE_FORMAT_MSG unless VALID_RESPONSE_FORMATS.include?(response_format)
  end
end

module Content
  class Fetcher
    FetcherError = Class.new(StandardError)
    TypeError = Class.new(StandardError)

    TYPES = {
      json: -> body { JSON.parse(body) },
      xml:  -> body { Hash.from_xml(body) }
    }.freeze

    def call(url:, type: :json)
      response = RestClient.get(url)

      get_values(response.body, type) unless response.body.blank?

    rescue RestClient::ExceptionWithResponse => e
      raise FetcherError, e.response
    end

    private

    def get_values(body, type)
      raise TypeError unless TYPES.include?(type)

      TYPES[type].call(body)

    rescue REXML::ParseException, JSON::ParserError
      raise TypeError
    end
  end
end

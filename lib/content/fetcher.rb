module Content
  class Fetcher
    TYPES = {
      json: -> body { JSON.parse(body) },
      xml:  -> body { Hash.from_xml(body) }
    }.freeze

    def call(url:, type: :json)
      response = RestClient.get(url)

      get_values(response.body, type)
    end

    private

    def get_values(body, type)
      TYPES[type].call(body)
    end
  end
end

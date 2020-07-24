module DealParser
  def self.parse(provider)
    response = RestClient.get(provider.endpoint)
    provider.parser.parse(response, provider.parse_options)
  end
end

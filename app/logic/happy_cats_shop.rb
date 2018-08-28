class HappyCatsShop
  ENDPOINT = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'.freeze

  def fetch
    return if response.blank?
    Hash.from_xml(response.body)['cats']['cat']
  end

  private

  def response
    @response ||= RestClient.get(ENDPOINT)
  end
end

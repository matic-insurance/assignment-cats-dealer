class CatsUnlimitedShop
  ENDPOINT = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'.freeze

  def fetch
    return if response.blank?
    JSON.parse(response.body)
  end

  private

  def response
    @response ||= RestClient.get(ENDPOINT)
  end
end

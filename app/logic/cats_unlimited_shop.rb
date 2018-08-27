class CatsUnlimitedShop

  ENDPOINT = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'

  def fetch
    return if response.blank?
    JSON.parse(response.body)
  end

  private

  attr_reader :response

  def response
    @response ||= RestClient.get(ENDPOINT)
  end
end

class ApiClient
  def initialize(url, max_retries)
    @url = url
    @max_retries = max_retries
  end

  def fetch
    retries ||= 0
    RestClient.get(@url)
  rescue RestClient::Exception
    retry if (retries += 1) < @max_retries
  end
end

class ApiClient
  def initialize(url, max_retries, client = RestClient)
    @url         = url
    @max_retries = max_retries
    @client      = client
  end

  def fetch
    retries ||= 0
    @client.get(@url)
  rescue Exception
    retry if (retries += 1) < @max_retries
  end
end

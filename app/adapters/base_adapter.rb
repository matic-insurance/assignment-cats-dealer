class BaseAdapter
  REQUEST_TIMEOUT = 10

  RemoteCat    = Struct.new(:breed, :price, :location, :image_url, keyword_init: true)
  RequestError = Class.new(StandardError)

  def cats
    raise NotImplementedError, "Method `#{name}` must be implemented!"
  end

  def request(url, method: :get, params: {})
    RestClient::Request.execute(
      method:  method,
      url:     url,
      params:  params,
      timeout: REQUEST_TIMEOUT
    )
  rescue => e
    raise RequestError, e.message
  end
end

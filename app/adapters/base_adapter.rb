# frozen_string_literal: true

class BaseAdapter
  REQUEST_TIMEOUT = 10

  RemoteCat    = Struct.new(:breed, :price, :location, :image_url, keyword_init: true)
  RequestError = Class.new(StandardError)

  def cats
    raise NotImplementedError, "Method `#{name}` must be implemented!"
  end

  private

  def request(url, method: :get, params: {})
    RestClient::Request.execute(
      method:  method,
      url:     url,
      params:  params,
      timeout: REQUEST_TIMEOUT
    )
  rescue StandardError => e
    raise RequestError, e.message
  end

  def build_cat(breed, price, location, image_url)
    RemoteCat.new(
      breed:     breed,
      price:     price.to_i,
      location:  location,
      image_url: image_url
    )
  end
end

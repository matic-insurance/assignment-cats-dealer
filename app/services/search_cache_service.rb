class SearchCacheService
  def initialize(search_id)
    @search_id = search_id
  end

  def write(value, ttl = cache_config['ttl'])
    Rails.cache.write(cache_key, SearchCacheService.generate_value(value),
                      expires_in: ttl)
  end

  def read
    cache_read_result = Rails.cache.read(cache_key)
    return unless cache_read_result

    SearchCacheService.parse_value(cache_read_result)
  end

  def self.generate_value(value)
    Base64.encode64(JSON.generate(value))
  end

  def self.parse_value(value)
    JSON.parse(Base64.decode64(value))
  end

  private

  attr_reader :search_id

  def cache_key
    "#{cache_config['key_prefix']}#{search_id}"
  end

  def cache_config
    Rails.configuration.search['search_cache']
  end
end

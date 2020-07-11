class CatsDealerConfig
  def self.provider_endpoints=(value)
    @endpoint = value
  end

  def self.provider_endpoints
    @endpoint
  end

  def self.parallel_processes=(value)
    @parallel_processes = value
  end

  def self.parallel_processes
    @parallel_processes
  end
end

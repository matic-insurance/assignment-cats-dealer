class StoreFetchLogicJson
  def initialize(data, path = nil)
    @data = data
    @path = path
  end

  def parse
    @path ? JSON.parse(@data).dig(*@path) : JSON.parse(@data)
  end
end

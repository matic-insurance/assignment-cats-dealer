class StoreFetchLogicXml
  def initialize(data, path = nil)
    @data = data
    @path = path
  end

  def parse
    @path ? Hash.from_xml(@data).dig(*@path) : Hash.from_xml(@data)
  end
end

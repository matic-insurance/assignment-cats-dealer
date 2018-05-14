require 'active_support/core_ext/module/delegation'

class Shop
  def initialize(config)
    @name     = config.name
    @mapper   = config.mapper
    @parser   = config.parser
    @enricher = config.enricher
    @wrapper  = config.wrapper
    @client   = config.client
  end

  delegate :wrap, to: :@wrapper
  delegate :enrich, to: :@enricher
  delegate :parse, to: :@parser
  delegate :fetch, to: :@client
  delegate :map_fields, to: :@mapper

  def products
    parse(fetch).map { |product| convert(product) }
  end

  def convert(product)
    wrap(enrich(map_fields(product)))
  end
end

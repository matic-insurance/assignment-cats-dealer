require_relative '../mappers/fields_mapper'
require_relative '../parsers/happy_cats_parser'
require_relative '../wrappers/model_wrapper'
require_relative '../enrichers/shop_info_enricher'
require_relative '../clients/api_client'

class HappyCatsConfig
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'.freeze
  FIELDS_MAPPING = {
    title: 'breed',
    cost: 'price',
    img: 'image'
  }.with_indifferent_access
  NAME = 'Happy Cats'.freeze
  MODEL = Cat
  PARSER = HappyCatsParser
  RETRIES = 3

  def self.mapper
    FieldsMapper.new(FIELDS_MAPPING)
  end

  def self.parser
    HappyCatsParser
  end

  def self.wrapper
    ModelWrapper.new(MODEL)
  end

  def self.enricher
    ShopInfoEnricher.new(NAME)
  end

  def self.client
    ApiClient.new(URL, RETRIES)
  end
end

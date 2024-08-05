# frozen_string_literal: true

class CatDealerService
  SHOPS = [
    { name: 'Happy Cats', url: ENV.fetch('HAPPY_CATS_ENDPOINT'), format: :xml },
    { name: 'Unlimited Cats',  url: ENV.fetch('UNLIMITED_CATS_ENDPOINT'), format: :json }
  ]

  class << self
    def find_best_deal(location, cats_type)
      new(location, cats_type).call
    end
  end

  def initialize(location, cats_type)
    @location = location
    @cats_type = cats_type
  end

  def call
    all_cats = fetch_cats
    filtered_cats = filter_cats(all_cats)
    find_best_deal(filtered_cats)
  end

  private
  attr_reader :location, :cats_type

  def fetch_cats
    SHOPS.flat_map do |shop|
      connector = shop_connector(shop)
      next unless connector

      response = connector.get_cats
      handle_response(shop, response)
    end.compact.flatten
  end

  def shop_connector(shop)
    ShopConnector.new(shop[:url], shop[:format])
  rescue ShopConnector::InvalidShopUrlError, ShopConnector::InvalidResponseFormatError => e
    Rails.logger.error("Connector error: #{e} for shop: #{shop[:name]}")
    nil
  end

  def handle_response(shop, response)
    if response[:error]
      Rails.logger.error("Error response from shop: #{shop[:name]} - #{response[:error]}")
    else
      response[:cats]
    end
  end

  def filter_cats(cats)
    cats.select do |cat|
      cat[Parser::BaseParser::LOCATION_KEY] == location &&
        cat[Parser::BaseParser::CAT_TYPE_KEY] == cats_type
    end
  end

  def find_best_deal(cats)
    return { error: 'Oops, no cats found' } if cats.empty?

    cats.min_by { |cat| cat[:price] }
  end
end

require 'rest-client'

module Parsing
  class ProductParser
    def initialize(shop, query_params={})
      @shop = shop
      # if we can add query params to url
      # add implementation to shop_url method
      @query_params = query_params
    end

    def call
      init
      @items = parse
      @items = root
      process_items
    end

    private

    def process_items
      # if any conventions or attribute names mapping needed - define in "attribute_#{name}" methods
      attribute_methods = self.methods.select { |m| m.to_s.start_with? 'attribute_' }
      @items.map do |item|
        attribute_methods.each do |method|
          attribute = method.to_s.split('_')[1]
          item[attribute] = self.send(method, item)
        end
        # storing shop id to track from which shop this product
        item["shop_id"] = @shop.id
        item.with_indifferent_access
      end
    end

    def products_url
      # concat query params to url here
      @shop.url
    end

    # define custom plural name in product definition
    def product_plural
      respond_to?(:pluralized) ? pluralized : @shop.product.pluralize
    end

    # by default we assume that parsed content is already an array of items
    def root
      @items
    end

    def model_name
      @shop.product.camelize
    end

    def shop_name
      @shop.name.parameterize.underscore
    end

    # if this method gets called - we successfully loaded format file but method parse is not defined there
    def parse
      raise "Method 'parse' for format #{@shop.format} is not implemented!"
    end

    def init
      setup_format
      setup_product_and_shop
    end

    # require needed parse method for specified format
    def setup_format
      begin
        # require file
        require_relative "formats/#{@shop.format}"
          # no file if format is not supoorted
      rescue LoadError
        raise "Format #{@shop.format} is not supported!"
      end
      # add methods from module to created object
      self.extend "Parsing::Formats::#{@shop.format.camelize}".constantize
    end

    # if any customizations on product or shop levels needed
    def setup_product_and_shop
      # checking if customizations file for product exists
      { products: @shop.product, shops: shop_name }.each do |type, name|
        if File.exist?("app/lib/#{type}/#{name}.rb")
          require_relative "../#{type}/#{name}"
          self.extend "#{type.to_s.camelize}::#{name.camelize}".constantize
        end
      end

    end
  end
end
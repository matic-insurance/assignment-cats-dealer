module Comparing
  class ProductComparator
    def initialize(items, product_name, request_id = nil, filter = {}, price_attribute = :price)
      @request_id = request_id
      @product_name = product_name
      @filter = filter
      @items = items.select { |i| include?(i) }
      # define field name, where price is defined for sorting purposes
      @price_attribute = price_attribute
    end

    def call
      populate_cheapest_products
    end

    private

    # checking if this item is matching our criteria
    def include?(item)
      @filter.each do |attribute, value|
        return false if item[attribute] != value
      end
      true
    end

    def populate_cheapest_products
      @items.sort_by! { |i| i[@price_attribute] }
      @items.each_with_index { |item, index| create_product(item, index) }
      # @items.each do |current|
      #  # checking if current price is still cheapest
      #  if current[@price_attribute] == @items[0][@price_attribute]
      #    create_product(current)
      #  else
      #    # all cheapest products are already processed, work is done
      #    return
      #  end
      # end
    end

    def create_product(product, index)
      # creating new product
      begin
        p = @product_name.constantize.send('new')
      rescue NameError => e
        raise "Product #{@product_name} is not supported! Create a model for this product."
      end
      product.each do |attr, val|
        # checking if attr exists
        if p.respond_to? attr
          # assigning value to current attribute
          p.send("#{attr}=", val)
        end
      end
      # assigning request id for tracking purposes
      p.send('request_id=', @request_id)
      # storing product position for tracking purposes
      p.send('show_position=', index)
      p.save!
    end
  end
end

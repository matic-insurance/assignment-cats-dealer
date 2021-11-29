# frozen_string_literal: true

module Shops
  class BaseShopApi
    def cat_list
      format(parse(RestClient.get(url)))
    rescue RestClient::Exception => e
      Rails.logger.error e.backtrace
      []
    end

    private

    def format(list)
      CatList.new(
        list.map { |c| hash_to_cat(c) }
      )
    end

    def parse(_data)
      raise MethodNotOverridden
    end

    def url
      raise MethodNotOverridden
    end

    def hash_to_cat(_h)
      raise MethodNotOverridden
    end
  end
end

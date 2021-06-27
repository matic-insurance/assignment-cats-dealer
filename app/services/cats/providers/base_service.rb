# frozen_string_literal: true

module Cats
  module Providers
    class BaseService
      include Singleton

      def data
        loader.load ::RestClient.get(url)
      end

      protected

      def loader
        raise NotImplementedError
      end

      def url
        raise NotImplementedError
      end
    end
  end
end

# frozen_string_literal: true

module Cats
  module Providers
    class BaseService
      include Singleton

      def data
        loader.load ::RestClient.get(url)
      rescue RestClient::ExceptionWithResponse => e
        raise ProviderUnavailableError, name
      end

      protected

      def loader
        raise NotImplementedError
      end

      def url
        raise NotImplementedError
      end

      def name
        raise NotImplementedError
      end
    end
  end
end

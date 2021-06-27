# frozen_string_literal: true

module Cats
  module Providers
    class BaseService
      include Singleton

      def data
        rows = loader.load(::RestClient.get(url))
        return rows unless self.class.const_defined?('MAPPINGS')

        rows.map { |row| map_attribute_names(row) }
      rescue RestClient::ExceptionWithResponse => e
        raise ProviderUnavailableError, name
      end

      protected

      def map_attribute_names(row)
        row.transform_keys! do |attr_name|
          self.class::MAPPINGS[attr_name] || attr_name
        end
      end

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

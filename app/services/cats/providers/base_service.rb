# frozen_string_literal: true

module Cats
  module Providers
    class BaseService
      include Singleton

      def data
        rows = load_raw_data ::RestClient.get(url)
        map_rows!(rows)
        rows
      rescue RestClient::ExceptionWithResponse => e
        raise ProviderUnavailableError, name
      end

      protected

      def map_rows!(rows)
        map_attr_names = self.class.const_defined?('KEYS_MAPPING')
        map_attr_values = self.class.const_defined?('VALUES_MAPPING')
        rows.each do |row|
          map_attribute_names(row) if map_attr_names
          map_attribute_values(row) if map_attr_values
        end
      end

      def map_attribute_names(row)
        row.transform_keys! do |attr_name|
          self.class::KEYS_MAPPING[attr_name] || attr_name
        end
      end

      def map_attribute_values(row)
        self.class::VALUES_MAPPING.each do |attr_name, mapper|
          row[attr_name] = mapper.call(row[attr_name])
        end
      end

      def load_raw_data(data)
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

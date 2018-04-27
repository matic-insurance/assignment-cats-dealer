module Providers
  module Models
    module JsonAttributes
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def json_attribute(key, as:)
          @attributes_mapping ||= {}
          @attributes_mapping.merge(key => as)
        end
      end

      def set_attributes(attributes)
        binding.pry
        @attributes_mapping.each do |key, model_attr|
          mutator = "#{model_attr}="
          value = attributes.fetch(key, nil)

          binding.pry
          send(mutator, value) if respond_to?(model_attr)
        end
      end
    end
  end
end

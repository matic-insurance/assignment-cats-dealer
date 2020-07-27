module Store
  module Providers
    module Decorators
      class BaseDecorator
        include AnimalStructure

        def initialize(response)
          @response = response
        end

        def decorate
          raise NotImplementedError
        end

        private

        attr_reader :response
      end
    end
  end
end

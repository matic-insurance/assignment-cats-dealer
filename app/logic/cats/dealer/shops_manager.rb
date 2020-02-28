
module Cats
  module Dealer
    class ShopsManager
      BASE_REGEX = /base_/

      def self.shops
        new.call
      end

      def call
        adapters_names
          .map(&:camelize)
          .map(&:constantize)
      end

      private

      def adapters_names
        Dir.glob(adapters_path)
           .map     { |file| File.basename(file, '.*') }
           .keep_if { |file| file !~ BASE_REGEX }
      end

      def adapters_path
        Rails.root.join('app', 'adapters', '*.rb')
      end
    end
  end
end

require 'providers/adapters/base'
require 'providers/clients/best_pussycat'
require 'providers/models/best_pussycat'

module Providers
  module Adapters
    class BestPussycat < Base
      protected

      def client
        Providers::Clients::BestPussycat.new
      end

      def base_model
        Providers::Models::BestPussycat
      end
    end
  end
end

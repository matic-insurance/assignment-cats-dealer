module Cats
  module Clients
    class Json
      def call(url)
        response = RestClient.get(url)
        ::Oj.load(response)
      rescue StandardError => e
        Rails.logger.error(e.message)
        []
      end
    end
  end
end

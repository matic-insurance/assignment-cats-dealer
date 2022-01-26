module Cats
  module Clients
    class Xml
      def call(url)
        response = RestClient.get(url)
        ::Ox.load(response, mode: :hash_no_attrs)
      rescue StandardError => e
        Rails.logger.error(e.message)
        []
      end
    end
  end
end

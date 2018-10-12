module Content
  module CatsUnlimited
    URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'.freeze

    class Adapter < ::Content::Adapter
      private

      def content
        @content ||= normalize(fetched_content, {
          name: 'name',
          price: 'price',
          location: 'location',
          image: 'image'
        })
      end

      def fetched_content
        @fetched_content ||= @fetcher.call(
          url: URL,
          type: :json
        )
      end
    end
  end
end

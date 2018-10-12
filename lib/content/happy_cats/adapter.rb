module Content
  module HappyCats
    URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'.freeze

    class Adapter < ::Content::Adapter
      private

      def content
        @content ||= normalize(fetched_content.fetch("cats").fetch("cat"), {
          name: 'title',
          price: 'cost',
          location: 'location',
          image: 'img'
        })
      end

      def fetched_content
        @fetched_content ||= @fetcher.call(
          url: URL,
          type: :xml
        )
      end
    end
  end
end

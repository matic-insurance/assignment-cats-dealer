module CatsDealers
  class FetchService
    class << self
      DEALERS = [
        ::CatsDealers::Adapters::CatsUnlimited,
        ::CatsDealers::Adapters::HappyCats
      ].freeze

      def call(params = {})
        data = []
        threads = []
        DEALERS.each do |dealer|
          threads << Thread.new do
            data << dealer.list(params)
          end
        end
        threads.map(&:join)
        data.flatten
      end
    end
  end
end

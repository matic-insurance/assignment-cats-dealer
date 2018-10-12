module Content
  class FetchCatsWorker
    include Sidekiq::Worker

    def perform
      Cats::Fetch.new().call
    end
  end
end

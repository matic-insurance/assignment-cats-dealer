module Cats
  class ManagerService
    extend Callable

    def initialize(params)
      @params = params
    end

    def perform
      fetch_cats_list
      filter_cats
    end

    private

    attr_reader :params,
                :cats_list

    def fetch_cats_list
      @cats_list = Store::ExecutorService.call
    end

    def filter_cats
      Cats::FilterService.(params.merge(cats_list: cats_list))
    end
  end
end

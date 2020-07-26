module Cats
  class FilterService
    extend Callable

    def initialize(params)
      @cats_type = params.fetch(:cats_type)
      @user_location = params.fetch(:user_location)
      @cats_list = params.fetch(:cats_list)
    end

    def perform
      filter_cats
    end

    private

    attr_reader :cats_type,
                :user_location,
                :cats_list

    def filter_cats
      filtered_cats = cats_list.select do |cat|
        cat.title == cats_type && cat.location == user_location
      end.sort_by { |obj| obj.price }
    end
  end
end

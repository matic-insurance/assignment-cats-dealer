module Shops
  class CheapestCatQuery < BaseQuery
    def initialize(query_params, initial_scope)
      @initial_scope = initial_scope
      @location = query_params[:location]
      @name = query_params[:name]
    end

    def call
      filtered_scope = filter_by_attribute(@initial_scope, :name, @name)
      filtered_scope = filter_by_attribute(filtered_scope, :location, @location)
      find_cheapest(filtered_scope)
    end

    private

    def find_cheapest(scope)
      return scope unless @location.present? && @name.present?

      scope.min_by { |record| record[:price].to_i }
    end
  end
end
